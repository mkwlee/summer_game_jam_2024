extends Node

@onready var white_tiles = %WhiteTiles
@onready var black_tiles = %BlackTiles
@onready var spotlight = %Spotlight

var world_state = 'white'
# Called when the node enters the scene tree for the first time.

func _ready():
	black_tiles.material.set_light_mode(2)
	white_tiles.material.set_light_mode(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spotlight.global_position = get_tree().current_scene.get_global_mouse_position()

func switch():
	if world_state == 'white':
		print('world state turning black')
		white_tiles.material.set_light_mode(2)
		black_tiles.material.set_light_mode(0)
		print(Color(100.0/255.0, 180.0/255.0, 45.0/255.0))
		spotlight.color = Color(100.0/255.0, 180.0/255.0, 45.0/255.0)
		#tile_map.set_layer_enabled(0, 0)
		#tile_map.set_layer_enabled(1, 1)
		world_state = 'black'
		return 'white'
	elif world_state == 'black':
		print('world state turning white')
		black_tiles.material.set_light_mode(2)
		white_tiles.material.set_light_mode(0)
		spotlight.color = Color(170 / 255.0, 55 / 255.0, 70 / 255.0, 1.0)
		#tile_map.set_layer_enabled(1, 0)
		#tile_map.set_layer_enabled(0, 1)
		world_state = 'white'
		return 'black'
