extends AudioStreamPlayer2D

const WHITE_SONG = preload("res://assets/music/white_song.mp3")
const BLACK_SONG = preload("res://assets/music/black_song.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_song(state):
	var pos = get_playback_position()
	if state == 'white':
		stream = WHITE_SONG
	else:
		stream = BLACK_SONG
	play(pos)
