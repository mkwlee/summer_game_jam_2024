extends CharacterBody2D


const SPEED : float = 150
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

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
		player_state = switch_sprite(game_manager.switch())

func switch_sprite(world_state):
	if world_state == 'white':
		print(animated_sprite.get_animation())
	elif world_state == 'black':
		print(animated_sprite.get_animation())
	return world_state
