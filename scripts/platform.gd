extends AnimatableBody2D
@onready var sprite = $Sprite2D
@onready var game_manager = %GameManager

@export_enum('white', 'black') var platform_state = 'white'

const WHITE_SPRITE = Rect2(0, 0, 32, 8)
const GREEN_SPRITE = Rect2(0, 8, 32, 8)
const BLACK_SPRITE = Rect2(0, 16, 32, 8)
const RED_SPRITE = Rect2(0, 24, 32, 8)
const WHITE_CANVAS_MATERIAL = preload("res://canvas/white_canvas_material.tres")
const BLACK_CANVAS_MATERIAL = preload("res://canvas/black_canvas_material.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_platform_state()
	if platform_state == 'white':
		sprite.material = WHITE_CANVAS_MATERIAL
		set_collision_layer_value(3, 0)
		set_collision_layer_value(2, 1)
	else:
		sprite.material = BLACK_CANVAS_MATERIAL
		set_collision_layer_value(2, 0)
		set_collision_layer_value(3, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_platform_state()

func set_platform_state():
	if platform_state == 'white':
		if game_manager.world_state == platform_state:
			sprite.region_rect = WHITE_SPRITE
		else: #World is BLACK
			sprite.region_rect = GREEN_SPRITE
	else:
		if game_manager.world_state == platform_state:
			sprite.region_rect = BLACK_SPRITE
		else: #World is WHITE
			sprite.region_rect = RED_SPRITE
