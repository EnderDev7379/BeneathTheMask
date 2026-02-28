extends CharacterBody2D
var HELTH;
var Vv;
var Vh;
var a;
var Vmax;

@onready var textBox = $"../CanvasLayer/ColorRect/Label";

var interaction_stage = 0;

const dialogues: Array[Array] = [
	[
"Zdravo spasioče,  hvala ti što možeš da nam pomogneš.",
"Zdravo, oćeš na kafu.",
"Šta si došao kod nas? Zar ne znaš da dolazi propast u ovo selo, odlazi odavde!!!"
	]
];

const descriptions: Array[String] = [
"Ovaj čovek je seljak, radi ceo dan u njivi ima ženu i dve mačke. 
Resurs koji donosi su žitarice.",
"Ovaj čovek je voćar, on gaji razno voće i ima sina Janka.
Resurs koji donosi su voće i Janko."
];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Vv = 0;
	Vh = 0;
	a = 33;
	Vmax = 20;
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
	
	if Input.is_action_just_pressed("Interaction"):
		if (get_tree().paused):
			interaction_stage += 1
		var raycast: ShapeCast2D = $ShapeCast2D;
		if raycast.is_colliding():
			var collider: Node = raycast.get_collider(0);
			if collider.get_parent() == $"../Npcs":
				$"../CanvasLayer/ColorRect".visible = true;
				if (interaction_stage == 0):
					textBox.text = dialogues[collider.get_meta("type")][randi_range(0, 3)];
				elif (interaction_stage == 1):
					textBox.text = descriptions[collider.get_meta("id")];
				get_tree().paused = true;
			
