extends AudioStreamPlayer

@onready var audio_stream_player: AudioStreamPlayer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.stream = load("res://music/music01.wav") if randi_range(0, 1) else load("res://music/music02.wav");
	audio_stream_player.play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
