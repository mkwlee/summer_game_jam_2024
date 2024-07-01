extends Area2D
@onready var timer = $Timer
@onready var player = %Player


func _on_body_entered(_body):
	#player.spotlight_trail.queue_free()
	#player.spotlight_focus.queue_free()
	#player.queue_free()
	timer.start()



func _on_timer_timeout():
	get_tree().reload_current_scene()
