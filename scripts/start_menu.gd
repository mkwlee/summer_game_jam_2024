extends Control
@onready var logo = $Logo
var forward = true
const TILESET_WHITE = preload("res://assets/sprites/tileset_white.png")
const TILESET_BLACK = preload("res://assets/sprites/tileset_black.png")
@onready var tile_map = %TileMap
const LEVEL_1 = preload("res://scenes/levels/level_1.tscn")
@onready var level_buttons = [$"VBoxContainer/HBoxContainer/Level 1", $"VBoxContainer/HBoxContainer/Level 2", $"VBoxContainer/HBoxContainer/Level 3", $"VBoxContainer/HBoxContainer/Level 4", $"VBoxContainer/HBoxContainer/Level 5", $"VBoxContainer/HBoxContainer/Level 6", $"VBoxContainer/HBoxContainer/Level 7", $"VBoxContainer/HBoxContainer/Level 8", $"VBoxContainer/HBoxContainer/Level 9", $"VBoxContainer/HBoxContainer/Level 10"]


# Called when the node enters the scene tree for the first time.
func _ready():
	for n in LevelCompletion.MAX_LEVEL_UNLOCKED:
		level_buttons[n].show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	if forward:
		logo.play("default")
		tile_map.tile_set.get_source(0).texture = TILESET_BLACK
		BackgroundMusic.change_song('black')
		forward = false
	else:
		logo.play_backwards("default")
		tile_map.tile_set.get_source(0).texture = TILESET_WHITE
		BackgroundMusic.change_song('white')
		forward = true

func _on_start_pressed():
	get_tree().change_scene_to_packed(LEVEL_1)
	
func _on_level_pressed(lvl_arg):
	get_tree().change_scene_to_file("res://scenes/levels/level_"+str(lvl_arg)+'.tscn')
