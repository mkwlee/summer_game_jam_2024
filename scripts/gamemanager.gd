extends Node

@onready var tile_map = %TileMap
@onready var spotlight = %Spotlight
@onready var player = %Player
const WHITE_CANVAS_MATERIAL = preload("res://Canvas/white_canvas_material.tres")
const BLACK_CANVAS_MATERIAL = preload("res://Canvas/black_canvas_material.tres")
const TILESET_WHITE = preload("res://sprites/tileset_white.png")
const TILESET_BLACK = preload("res://sprites/tileset_black.png")

var world_state = 'white'
# Called when the node enters the scene tree for the first time.

func _ready():
	WHITE_CANVAS_MATERIAL.set_light_mode(0)
	BLACK_CANVAS_MATERIAL.set_light_mode(2)
	tile_map.tile_set.get_source(0).texture = TILESET_WHITE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func switch_world():
	if world_state == 'white':
		print('world state turning black')

		WHITE_CANVAS_MATERIAL.set_light_mode(2)
		BLACK_CANVAS_MATERIAL.set_light_mode(0)
		tile_map.tile_set.get_source(0).texture = TILESET_BLACK
		
		world_state = 'black'
		return 'white'
	elif world_state == 'black':
		print('world state turning white')
		
		WHITE_CANVAS_MATERIAL.set_light_mode(0)
		BLACK_CANVAS_MATERIAL.set_light_mode(2)
		tile_map.tile_set.get_source(0).texture = TILESET_WHITE
		
		world_state = 'white'
		return 'black'
