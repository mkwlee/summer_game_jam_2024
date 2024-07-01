extends Node2D
@onready var game_manager = %GameManager
@onready var point_light = $PointLight2D

const COLOR_RED = Color(170 / 255.0, 55 / 255.0, 70 / 255.0, 1.0)
const COLOR_GREEN = Color(100.0/255.0, 180.0/255.0, 45.0/255.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	if game_manager.world_state == 'white':
		point_light.color = COLOR_RED
	else:
		point_light.color = COLOR_GREEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_manager.world_state == 'white':
		point_light.color = COLOR_RED
	else:
		point_light.color = COLOR_GREEN
