extends CharacterBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_camera: Camera2D = $PlayerCamera
@onready var raycast: ShapeCast2D = $ShapeCast2D

enum Direction { SOUTH = 1, EAST = 2, NORTH = 4, WEST = 8, SOUTHEAST = 3, NORTHEAST = 6, SOUTHWEST = 9, NORTHWEST = 12 }
const DirectionDict: Dictionary = { 1: "south", 2: "east", 4: "north", 8: "west", 3: "southeast", 6: "northeast", 9: "southwest", 12: "northwest" }

@export_group("Physics")
@export var SPEED: float = 150.0;
@export var ACCELERATION: float = 10.0;
@export var DECELERATION: float = 30.0;

@export_group("Camera")
@export var CAMERA_ZOOM: int = 3;
@export_range(1, 64) var CAMERA_DELAY: int = 8;

@export_group("Other")
@export_subgroup("Direction")
@export_enum("4-Direction", "8-Direction") var direction_mode: int = 1;
@export_enum("Vertical", "Horizontal") var primary_direction: int = 0;
@export var direction: Direction = Direction.SOUTH;

@export_subgroup("")
@export var interacting: bool = false;

func _ready() -> void:
	player_camera.zoom = Vector2(CAMERA_ZOOM, CAMERA_ZOOM);

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var delta_mult = delta * 60;
	var new_direction: Direction;
	
	var direction_y = Input.get_axis("move_up", "move_down");
	if direction_y:
		new_direction = Direction.SOUTH if direction_y > 0 else Direction.NORTH;
		raycast.rotation_degrees = 0 if direction_y > 0 else 180;
		velocity.y = move_toward(velocity.y, direction_y * SPEED * delta_mult, ACCELERATION * delta_mult);
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION * delta_mult);
	
	var direction_x := Input.get_axis("move_left", "move_right");
	if direction_x:
		if (primary_direction):
			if (direction_mode):
				new_direction += Direction.EAST if direction_x > 0 else Direction.WEST;
			else:
				new_direction = Direction.EAST if direction_x > 0 else Direction.WEST;
				
		else:
			if (direction_mode || !new_direction):
				new_direction += Direction.EAST if direction_x > 0 else Direction.WEST;
		
		if (primary_direction || !direction_y):
			raycast.rotation_degrees = -90 if direction_x > 0 else 90;
		
		velocity.x = move_toward(velocity.x, direction_x * SPEED * delta_mult, ACCELERATION * delta_mult);
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta_mult);
	
	if (new_direction):
		direction = new_direction;
		animation_player.play("walk_%s" % DirectionDict[direction]);
	else: animation_player.play("idle_%s" % DirectionDict[direction]);
	
	move_and_slide();

	player_camera.position = player_camera.position.move_toward(position, abs(position.distance_to(player_camera.position))/CAMERA_DELAY);
