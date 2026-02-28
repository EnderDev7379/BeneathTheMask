extends ShapeCast2D



@onready var textBox = $"../../CanvasLayer/DialogueBox/Label";

var interaction_stage = 0;

const dialogues: Array[Array] = [
	[
"Zdravo spasioče,  hvala ti što možeš da nam pomogneš.",
"Zdravo, oćeš na kafu.",
"Šta si došao kod nas? Zar ne znaš da dolazi propast u ovo selo, odlazi odavde!!!"
	]
];

const descriptions: Array[Array] = [
	[
"Ovaj čovek je seljak, radi ceo dan u njivi ima ženu i dve mačke. 
Resurs koji donosi su žitarice.",
"Ovaj čovek je voćar, on gaji razno voće i ima sina Janka.
Resurs koji donosi su voće i Janko."
	]
];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interaction"):
		if (get_tree().paused):
			interaction_stage += 1
			get_tree().paused = false;
		var raycast: ShapeCast2D = $".";
		if raycast.is_colliding():
			var collider: Node = raycast.get_collider(0);
			if collider.get_parent() == $"../../Npcs":
				$"../../CanvasLayer/DialogueBox".visible = true;
				if (interaction_stage == 0):
					textBox.text = dialogues[collider.get_meta("type")][randi_range(0, 2)];
				elif (interaction_stage == 1):
					textBox.text = descriptions[collider.get_meta("type")][collider.get_meta("id")];;
				elif (interaction_stage == 2):
					$"../../CanvasLayer/DialogueBox".visible = false;
					return
				get_tree().paused = true;
