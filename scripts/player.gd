extends CharacterBody2D


const SPEED : float = 150
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var spotlight_trail = $SpotlightTrail
@onready var spotlight_focus = $SpotlightFocus

var player_state = 'black'

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
			
		var current_frame = animated_sprite.get_frame()
		var current_progress = animated_sprite.get_frame_progress()	
		animated_sprite.play("walk_"+player_state)
		animated_sprite.set_frame_and_progress(current_frame, current_progress)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var current_frame = animated_sprite.get_frame()
		var current_progress = animated_sprite.get_frame_progress()	
		animated_sprite.play("idle_"+player_state)
		animated_sprite.set_frame_and_progress(current_frame, current_progress)
	move_and_slide()
	
	if Input.is_action_just_pressed('change_world'):
		player_state = game_manager.switch_world()
		switch_sprite()
		
		
	var light_direction = get_global_mouse_position() - global_position
	light_direction = light_direction.normalized()
	spotlight_focus.global_position = get_global_mouse_position()
	spotlight_trail.rotation = atan2(light_direction.y, light_direction.x)
	spotlight_trail.scale.x = get_global_mouse_position().distance_to(global_position) / 120

func switch_sprite():
	if player_state == 'white':
		set_collision_mask_value(2, 0)
		set_collision_mask_value(3, 1)
		
		spotlight_trail.color = Color(100.0/255.0, 180.0/255.0, 45.0/255.0)
		spotlight_focus.color = Color(100.0/255.0, 180.0/255.0, 45.0/255.0)
		spotlight_trail.shadow_item_cull_mask = 4
		
	elif player_state == 'black':
		set_collision_mask_value(3, 0)
		set_collision_mask_value(2, 1)
		
		spotlight_trail.color = Color(170 / 255.0, 55 / 255.0, 70 / 255.0, 1.0)
		spotlight_focus.color = Color(170 / 255.0, 55 / 255.0, 70 / 255.0, 1.0)
		spotlight_trail.shadow_item_cull_mask = 2
