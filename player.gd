extends CharacterBody2D
var HELTH;
var V;
var a;
var Vmax;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	V = 0;
	a = 10;
	Vmax = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_up"):
		if V <= Vmax:
			V += a*delta
		position.y -= V;
