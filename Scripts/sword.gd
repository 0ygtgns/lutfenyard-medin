extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var SPEED = 200.0
@export var STOP_THRESHOLD = 5.0
@export var DAMAGE = 10

var movement_direction: Vector2
var spawnPos: Vector2

func _ready():
	global_position = spawnPos
	rotation = movement_direction.angle()
	# Set collision layers (player weapon)
	collision_layer = 0b1000  # layer 3 (player_weapon)
	collision_mask = 0b0010   # layer 2 (enemy)

func _physics_process(delta):
	velocity = movement_direction * SPEED
	animation_player.play("sword_flip")
	move_and_slide()
	
	# Check for collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy"):
			collision.get_collider().take_damage(DAMAGE)
			queue_free()
			return
	
	# Check for low velocity
	if velocity.length() < STOP_THRESHOLD:
		queue_free()
