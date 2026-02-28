extends Node2D


@onready var npcs: Node2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for npc in npcs.get_children():
		if (npc.get_meta("type") == -1):
			npc.set_meta("type", randi_range(0, 1));
		if (npc.get_meta("id") == -1):
			npc.set_meta("id", randi_range(0, 21) if npc.get_meta("type") == 1 else randi_range(0, 20))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
