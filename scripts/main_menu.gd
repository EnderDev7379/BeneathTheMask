extends Control


func _on_british_pressed() -> void:
	TranslationServer.set_locale("en");

func _on_sertbian_pressed() -> void:
	TranslationServer.set_locale("sr");

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn");

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn");

func _on_exit_button_pressed() -> void:
	get_tree().quit();
