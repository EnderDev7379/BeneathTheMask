extends Control

@onready var label: Label = $ColorRect/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.modulate.a = 0;
	var total_saved: int = PersistantData.bad_saved + PersistantData.good_saved;
	var percentage_good: int = PersistantData.good_saved * 100 / total_saved;
	label.text = tr("end_%d" % (percentage_good / 25 + 1))
