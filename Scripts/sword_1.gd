extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var SPEED = 200.0
@export var STOP_THRESHOLD = 5.0

# Now using Vector2
var movement_direction: Vector2  # Renamed from 'move_direction' to avoid confusion
var spawnPos: Vector2

func _ready():
	global_position = spawnPos
	rotation = movement_direction.angle()  # Face movement direction

func _physics_process(delta):
	velocity = movement_direction * SPEED
	animation_player.play("sword_flip")
	move_and_slide()
	
	if velocity.length() < STOP_THRESHOLD:
		queue_free()
