extends Node2D


@onready var npcs: Node2D = $"."

var id_maximums: Array[int] = [21, 20, 0]
var free_ids: Array[Array] = [[],[],[]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup
	for i in range(3):
		for j in range(id_maximums[i]):
			free_ids[i].append(j)
	print(free_ids)
	
	# Initial pass, see what's already taken
	for npc in npcs.get_children():
		var type = npc.get_meta("type");
		var id = npc.get_meta("id");
		if (type != -1 && id != -1):
			free_ids[type] = free_ids[type].filter(func(val): return val != id);
	print(free_ids)
	
	for npc in npcs.get_children():
		var type = npc.get_meta("type");
		var id = npc.get_meta("id");
		if (type == -1):
			type = randi_range(0, 1);
			if (len(free_ids[type]) < 1):
				print("NPC ", npc.name, " had full type ", type);
				type = 1 - type;
			if (len(free_ids[type]) < 1):
				npcs.remove_child(npc);
				print("NPC ", npc.name, " removed, both types full");
				continue;
			npc.set_meta("type", type);
		if (id == -1):
			id = free_ids[type].pick_random();
			free_ids[type] = free_ids[type].filter(func(val): return val != id);
			npc.set_meta("id", id);
		print("NPC ", npc.name, " is type ", type, " and id ", id);
		print(free_ids)
