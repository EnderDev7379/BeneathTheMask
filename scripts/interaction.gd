extends ShapeCast2D


@onready var textBox: Label = $"../../../CanvasLayer/DialogueBox/Label"
@onready var player: CharacterBody2D = $".."
@onready var raycast: ShapeCast2D = $".";
@onready var label_2: Label = $"../../../CanvasLayer/Label2"


var interaction_stage = 0;

const types: Array[String] = [
	"good", "bad", "oldman"
];

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interaction"):
		if (get_tree().paused):
			interaction_stage += 1
			get_tree().paused = false;
		if raycast.is_colliding():
			var collider: Node = raycast.get_collider(0);
			if collider.get_parent() == $"../../../Npcs":
				if (PersistantData.bad_saved + PersistantData.good_saved >= 10): return;
				textBox.get_parent().visible = true;
				if (collider.get_meta("interacted", false)):
					if (interaction_stage == 0):
						textBox.text = tr("greet_interacted_%s" % randi_range(1, 3));
					else:
						interaction_stage = 0;
						textBox.get_parent().visible = false;
						return;
				else:
					if (interaction_stage == 0):
						textBox.text = tr("greet_%s_%d" % [types[collider.get_meta("type")], randi_range(1, 3) if collider.get_meta("type") != 2 else collider.get_meta("id")]);
					elif (interaction_stage == 1):
						if (collider.get_meta("type") == 2):
							interaction_stage = 0;
							textBox.get_parent().visible = false;
							return;
						textBox.text = tr("cata_%s_%d" % [types[collider.get_meta("type")], collider.get_meta("id")]);
					elif (interaction_stage == 2):
						textBox.text = tr("save_interact");
					else:
						if (collider.get_meta("type") == 0):
							PersistantData.good_saved += 1;
							label_2.text = "%d/10" % (PersistantData.good_saved+PersistantData.bad_saved);
						elif (collider.get_meta("type") == 1):
							PersistantData.bad_saved += 1;
							label_2.text = "%d/10" % (PersistantData.good_saved+PersistantData.bad_saved);
						interaction_stage = 0;
						collider.set_meta("interacted", true);
						textBox.get_parent().visible = false;
						return;
				get_tree().paused = true;
			elif collider == $"../../Bunker":
				if (interaction_stage == 0):
					if (PersistantData.good_saved + PersistantData.bad_saved != 10):
						textBox.get_parent().visible = true;
						textBox.text = tr("bunker_insufficient");
					else:
						await Fade.fade_out().finished;
						get_tree().change_scene_to_file("res://scenes/ending.tscn");
						return;
				else:
					textBox.get_parent().visible = false;
				get_tree().paused = true;
	
	if Input.is_action_just_pressed("UnInteraction"):
		if (interaction_stage == 0 && raycast.get_collider(0) == $"../../Bunker"):
			get_tree().paused = false;
			textBox.get_parent().visible = false;
			return;
		if (interaction_stage == 2):
			get_tree().paused = false;
			interaction_stage = 0;
			raycast.get_collider(0).set_meta("interacted", true);
			textBox.get_parent().visible = false;
			return;
