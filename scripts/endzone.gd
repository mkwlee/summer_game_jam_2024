extends Area2D
@onready var game_manager = %GameManager
@onready var player = %Player
@onready var timer = $Timer

func _on_body_entered(_body):
	player.find_child('AnimationPlayer').play('level_complete')
	player.find_child('SpotlightFocus').hide()
	player.is_static = true
	player.global_position = global_position
	player.velocity = Vector2(0, 0)
	timer.start()
	


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/levels/level_"+str(game_manager.level+1)+'.tscn')
