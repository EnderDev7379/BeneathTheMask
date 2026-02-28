extends ShapeCast2D



@onready var textBox = $"../../CanvasLayer/DialogueBox/Label";
@onready var player: CharacterBody2D = $".."
@onready var raycast: ShapeCast2D = $".";


var interaction_stage = 0;

const dialogues: Array[Array] = [
	[
"Zdravo spasioče,  hvala ti što možeš da nam pomogneš.",
"Zdravo, oćeš na kafu.",
"Šta si došao kod nas? Zar ne znaš da dolazi propast u ovo selo, odlazi odavde!!!"
	],
	[
"Zdrav0 spasioče, hvala ti što možeš da nam pomogneš.",
"Šta si došao u ovo selo da nam daješ lažnu nadu, odlazi odavde!!!",
"Zdravo lepotice, nadam se da si dobro i da uživaš u našem selu pre nego što nestane."
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

const dialogues_repeated: Array[String] = [
"Немамо о чему више да причамо.",
"Већ сам све рекао. Приђите другима.",
"Лепо смо разговарали."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interaction"):
		if (get_tree().paused):
			interaction_stage += 1
			get_tree().paused = false;
		if raycast.is_colliding():
			var collider: Node = raycast.get_collider(0);
			if collider.get_parent() == $"../../Npcs":
				$"../../CanvasLayer/DialogueBox".visible = true;
				if (collider.get_meta("interacted")):
					if (interaction_stage == 0):
						textBox.text = dialogues_repeated[randi_range(0, 2)];
					else:
						interaction_stage = 0;
						$"../../CanvasLayer/DialogueBox".visible = false;
						return;
				else:
					if (interaction_stage == 0):
						textBox.text = dialogues[collider.get_meta("type")][randi_range(0, 2)];
					elif (interaction_stage == 1):
						textBox.text = descriptions[collider.get_meta("type")][collider.get_meta("id")];;
					elif (interaction_stage == 2 && collider.get_meta("type") != 2):
						textBox.text = "Da li da spasiš ovu osobu?\n(E = da, Q = ne)"
					else:
						if (collider.get_meta("type") == 0):
							player.set_meta("good_accepted", player.get_meta("good_accepted") + 1);
						elif (collider.get_meta("type") == 1):
							player.set_meta("bad_accepted", player.get_meta("bad_accepted") + 1);
						interaction_stage = 0;
						collider.set_meta("interacted", true);
						$"../../CanvasLayer/DialogueBox".visible = false;
						return;
				get_tree().paused = true;
	
	if Input.is_action_just_pressed("UnInteraction"):
		if (interaction_stage == 2):
			get_tree().paused = false;
			interaction_stage = 0;
			raycast.get_collider(0).set_meta("interacted", true);
			$"../../CanvasLayer/DialogueBox".visible = false;
			return;
