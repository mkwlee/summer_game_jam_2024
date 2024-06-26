extends Camera2D
@onready var player = %Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_global_mouse_position() - player.global_position
	direction = direction.normalized()
	
	if get_global_mouse_position().distance_to(player.global_position) < get_viewport().size.x / 3:
		global_position = player.global_position + direction * get_global_mouse_position().distance_to(player.global_position)
	else:
		global_position = player.global_position + direction * (get_viewport().size.x / 4)
	#print(y_pos / x_pos)
	
