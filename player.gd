extends CharacterBody2D
var HELTH;
var Vv;
var Vh;
var a;
var Vmax;
@onready var anim = $Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Vv = 0;
	Vh = 0;
	a = 33;
	Vmax = 20;
	print(anim);
	anim.play("walk");
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_up"):
		$ShapeCast2D.rotation_degrees = 180;
		if Vv >= -Vmax:
			Vv -= a*delta
		
	elif Input.is_action_pressed("move_down"):
		$ShapeCast2D.rotation_degrees = 0;
		if Vv <= Vmax:
			Vv += a*delta
		
	else:
		if Vv > 0.1:
			Vv *= 0.75;
		else:
			Vv = 0;
	if Input.is_action_pressed("move_left"):
		$ShapeCast2D.rotation_degrees = 90;
		if Vh >= -Vmax:
			Vh -= a*delta
		
	elif Input.is_action_pressed("move_right"):
		$ShapeCast2D.rotation_degrees = 270;
		if Vh <= Vmax:
			Vh += a*delta
		
	else:
		if Vh > 0.1:
			Vh *= 0.75;
		else:
			Vh = 0;
	move_and_collide(Vector2(Vh, Vv));
	update_animation();
func update_animation():
	var moving = Vector2(Vh, Vv).length() > 1
	
	if anim == null:
		return
	
	if moving:
		if anim.current_animation != "walk":
			anim.play("walk")
	else:
		if anim.current_animation != "idle":
			anim.play("idle")
