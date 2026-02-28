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
	a = 33;
	Vmax = 100;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_up"):
		if Vv <= Vmax:
			Vv -= a*delta
		
	elif Input.is_action_pressed("move_down"):
		if Vv <= Vmax:
			Vv += a*delta
		
	else:
		if Vv > 0.1:
			Vv *= 0.75;
		else:
			Vv = 0;
	if Input.is_action_pressed("move_left"):
		if Vh <= Vmax:
			Vh -= a*delta
		
	elif Input.is_action_pressed("move_right"):
		if Vh <= Vmax:
			Vh += a*delta
		
	else:
		if Vh > 0.1:
			Vh *= 0.75;
		else:
			Vh = 0;
	position.x += Vh;
	position.y += Vv;
