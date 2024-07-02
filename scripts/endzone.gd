extends Area2D
@onready var game_manager = %GameManager
@onready var player = %Player
@onready var timer = $Timer
@onready var portal = $Portal

var portaling = false

func _on_body_entered(_body):
	player.find_child('AnimationPlayer').play('level_complete')
	player.find_child('SpotlightFocus').hide()
	portaling = true
	player.is_static = true
	player.global_position = global_position
	player.velocity = Vector2(0, 0)
	portal.play()
	timer.start()
	
func _process(_delta):
	if portaling == true:
		player.global_position = global_position

func _on_timer_timeout():
	LevelCompletion.MAX_LEVEL_UNLOCKED = game_manager.level+1
	get_tree().change_scene_to_file("res://scenes/levels/level_"+str(game_manager.level+1)+'.tscn')
