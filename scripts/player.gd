extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var spotlight_focus = $SpotlightFocus

@onready var jump = $Jump
@onready var switch = $Switch


const COLOR_RED = Color(170 / 255.0, 55 / 255.0, 70 / 255.0, 1.0)
const COLOR_GREEN = Color(100.0/255.0, 180.0/255.0, 45.0/255.0)

const SPEED_VELOCITY = 150.0
const SPEED_ACC = 1500
const JUMP_VELOCITY = 400.0
var player_state = 'black'
var switch_allowed = true
var jump_allowed = true
var wall_jump_state = false
var is_static = false
var platform_velocity = Vector2(0, 0)
var was_on_floor = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if game_manager.world_state == 'white':
		player_switch('black')
	else:
		player_switch('white')
		
	if game_manager.world_shift_on:
		spotlight_movement()
	else:
		spotlight_focus.hide()
		
	var current_frame = animated_sprite.get_frame()
	var current_progress = animated_sprite.get_frame_progress()	
	animated_sprite.play("idle_"+player_state)
	animated_sprite.set_frame_and_progress(current_frame, current_progress)

func _physics_process(delta):
	
	if not is_static:
		player_movement(delta)
		player_jump_and_switch(delta)
	move_and_slide()
	
	spotlight_movement()

func player_jump_and_switch(delta):
	if is_on_floor():
		jump_allowed = true
		switch_allowed = false
		
		if Input.is_action_just_pressed("ui_accept"):
			player_jump()
	else:
		if was_on_floor:
			switch_allowed = true
			
		velocity.y += gravity * delta
		if Input.is_action_just_pressed('change_world') and switch_allowed and game_manager.world_shift_on:
			switch.play()
			player_switch(game_manager.world_switch())
			switch_allowed = false
			jump_allowed = true
			
		if Input.is_action_just_pressed("ui_accept") and jump_allowed:
			player_jump()
			
	was_on_floor = is_on_floor()
func player_jump():
	velocity.y = -JUMP_VELOCITY+platform_velocity.y
	platform_velocity.x = get_platform_velocity().x
	
	jump.play()
	var current_frame = animated_sprite.get_frame()
	var current_progress = animated_sprite.get_frame_progress()	
	animated_sprite.play("jump_"+player_state)
	animated_sprite.set_frame_and_progress(current_frame, current_progress)
	jump_allowed = false

func player_movement(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	platform_velocity.y = get_platform_velocity().y
	
	if direction:
		velocity.x = move_toward(velocity.x, direction*SPEED_VELOCITY, SPEED_ACC*delta)
		# Sprite direction
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		# Animation
		if is_on_floor():
			var current_frame = animated_sprite.get_frame()
			var current_progress = animated_sprite.get_frame_progress()	
			animated_sprite.play("walk_"+player_state)
			animated_sprite.set_frame_and_progress(current_frame, current_progress)
	else:
		# Animation
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED_VELOCITY)
			var current_frame = animated_sprite.get_frame()
			var current_progress = animated_sprite.get_frame_progress()	
			animated_sprite.play("idle_"+player_state)
			animated_sprite.set_frame_and_progress(current_frame, current_progress)
		else:
			velocity.x = platform_velocity.x
			var current_frame = animated_sprite.get_frame()
			var current_progress = animated_sprite.get_frame_progress()	
			animated_sprite.play("jump_"+player_state)
			animated_sprite.set_frame_and_progress(current_frame, current_progress)
	
func player_switch(new_state):
	player_state = new_state
	
	if player_state == 'white':
		set_collision_mask_value(2, 0)
		set_collision_mask_value(3, 1)
		
		spotlight_focus.color = COLOR_GREEN
		
	elif player_state == 'black':
		set_collision_mask_value(3, 0)
		set_collision_mask_value(2, 1)
		
		spotlight_focus.color = COLOR_RED

func spotlight_movement():
	var light_direction = get_global_mouse_position() - global_position
	light_direction = light_direction.normalized()
	spotlight_focus.global_position = get_global_mouse_position()
