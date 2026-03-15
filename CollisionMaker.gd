extends Node

@onready var root: Node = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return;
	for sprite in root.get_children():
		if !(sprite is Sprite2D): continue;
		var staticBody: StaticBody2D = StaticBody2D.new();
		var collisionShape: CollisionShape2D = CollisionShape2D.new();
		
		var shape: Shape2D = RectangleShape2D.new();
		shape.size = sprite.texture.get_size() * sprite.scale;
		collisionShape.shape = shape;
		
		staticBody.position = sprite.position;
		sprite.position = Vector2.ZERO;
		
		staticBody.add_child(collisionShape);
		#print(staticBody.get_children().map(func(node: Node): return node.name))
		root.remove_child(sprite);
		#print(root.get_children().map(func(node: Node): return node.name))
		staticBody.add_child(sprite);
		#print(staticBody.get_children().map(func(node: Node): return node.name));
		root.add_child(staticBody);
		#print(staticBody.owner.name);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
