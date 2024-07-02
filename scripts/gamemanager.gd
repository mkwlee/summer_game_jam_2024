extends Node

@onready var tile_map = %TileMap
@onready var player = %Player
@onready var killzone = $"../Killzone"

const WHITE_CANVAS_MATERIAL = preload("res://canvas/white_canvas_material.tres")
const BLACK_CANVAS_MATERIAL = preload("res://canvas/black_canvas_material.tres")
const TILESET_WHITE = preload("res://assets/sprites/tileset_white.png")
const TILESET_BLACK = preload("res://assets/sprites/tileset_black.png")

@export var level : int
@export var world_shift_on : bool = true
@export_enum('white', 'black') var world_state = 'white'

func _ready():
	if world_state == 'white':
		WHITE_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_NORMAL)
		BLACK_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_LIGHT_ONLY)
		tile_map.tile_set.get_source(0).texture = TILESET_WHITE
		BackgroundMusic.change_song('white')
	else:
		WHITE_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_LIGHT_ONLY)
		BLACK_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_NORMAL)
		tile_map.tile_set.get_source(0).texture = TILESET_BLACK
		BackgroundMusic.change_song('black')
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape_level"):
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	if Input.is_action_just_pressed("self_destruct"):
		killzone.player_death()
	
func world_switch():
	if world_state == 'white': #World is BLACK
		
		WHITE_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_LIGHT_ONLY)
		BLACK_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_NORMAL)
		tile_map.tile_set.get_source(0).texture = TILESET_BLACK
		BackgroundMusic.change_song('black')
		world_state = 'black'
		return 'white'
	elif world_state == 'black': #World is WHITE
		
		WHITE_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_NORMAL)
		BLACK_CANVAS_MATERIAL.set_light_mode(CanvasItemMaterial.LIGHT_MODE_LIGHT_ONLY)
		tile_map.tile_set.get_source(0).texture = TILESET_WHITE
		BackgroundMusic.change_song('white')
		world_state = 'white'
		return 'black'
