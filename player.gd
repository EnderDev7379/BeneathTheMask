extends CharacterBody2D
var HELTH;
var Vv;
var Vh;
var a;
var Vmax;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Vv = 0;
	Vh = 0;
	a = 10;
	Vmax = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_up"):
		if Vv <= Vmax:
			Vv += a*delta
		position.y -= Vv;
	if Input.is_action_pressed("move_down"):
		if Vv <= Vmax:
			Vv += a*delta
		position.y += Vv;
	if Input.is_action_pressed("move_left"):
		if Vh <= Vmax:
			Vh += a*delta
		position.x -= Vh;
	if Input.is_action_pressed("move_right"):
		if Vh <= Vmax:
			Vh += a*delta
		position.x += Vh;
