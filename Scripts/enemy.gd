extends CharacterBody2D
@onready var health_bar = $HealthBar
@export var SPEED = 130
@export var MAX_HEALTH = 100
var current_health = MAX_HEALTH
@onready var projectile = load("res://Scenes/sword1.tscn")
@onready var game: Node2D = $".."

var move_direction = Vector2.ZERO

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	var directionX := Input.get_axis("Enemy_Left", "Enemy_Right")
	var directionY := Input.get_axis("Enemy_Top", "Enemy_Bottom")

	move_direction = Vector2(directionX, directionY).normalized()
	velocity = move_direction * SPEED

	if move_direction.length_squared() > 0:
		rotation = move_direction.angle() # Get the angle in radians

	move_and_slide()

func shoot():
	var instance = projectile.instantiate()
	instance.movement_direction = move_direction.normalized()  # Pass Vector2 directly
	instance.spawnPos = global_position
	game.add_child.call_deferred(instance)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Enemy__Sword"):
		shoot()

func take_damage(amount):
	current_health -= amount
	health_bar.value = current_health
	if current_health <= 0:
		die()

func die():
	queue_free()
	# Add death effects here
