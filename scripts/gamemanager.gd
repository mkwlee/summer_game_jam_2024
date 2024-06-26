extends Node

@onready var tile_map = %TileMap
@onready var spotlight = %Spotlight
@onready var player = %Player
const WHITE_CANVAS_MATERIAL = preload("res://Canvas/white_canvas_material.tres")
const BLACK_CANVAS_MATERIAL = preload("res://Canvas/black_canvas_material.tres")

var world_state = 'white'
# Called when the node enters the scene tree for the first time.

func _ready():
	#black_tiles.material.set_light_mode(2)
	#white_tiles.material.set_light_mode(0)
	WHITE_CANVAS_MATERIAL.set_light_mode(0)
	BLACK_CANVAS_MATERIAL.set_light_mode(2)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func switch_world():
	if world_state == 'white':
		print('world state turning black')

		WHITE_CANVAS_MATERIAL.set_light_mode(2)
		BLACK_CANVAS_MATERIAL.set_light_mode(0)
		
		world_state = 'black'
		return 'white'
	elif world_state == 'black':
		print('world state turning white')
		
		WHITE_CANVAS_MATERIAL.set_light_mode(0)
		BLACK_CANVAS_MATERIAL.set_light_mode(2)
		
		world_state = 'white'
		return 'black'
