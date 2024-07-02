extends Area2D
@onready var timer = $Timer
@onready var player = %Player
@onready var death = $Death


func _on_body_entered(_body):
	player_death()



func _on_timer_timeout():
	get_tree().reload_current_scene()

func player_death():
	death.play()
	player.is_static = true
	player.velocity.y = 50
	player.rotation_degrees = -90
	player.find_child('CollisionShape2D').queue_free()
	timer.start()
