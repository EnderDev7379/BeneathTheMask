extends Timer

@onready var label: Label = $"../CanvasLayer/Label"
@onready var timer: Timer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "%d:%d.%d" % [timer.time_left / 60, int(timer.time_left) % 60, int((timer.time_left - int(timer.time_left)) * 1000)];


func _on_timeout() -> void:
	
	pass # Replace with function body.
