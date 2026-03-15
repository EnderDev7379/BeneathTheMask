extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body == $"../Environment/TopDownPlayer":
		PersistantData.bad_saved = -20;
		PersistantData.good_saved = -22;
		await Fade.fade_out(5).finished;
		get_tree().change_scene_to_file("res://scenes/ending.tscn");
		Fade.fade_in(5);
