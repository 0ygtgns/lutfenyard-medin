extends CharacterBody2D

@export var SPEED = 130
@onready var projectile = load("res://Scenes/sword.tscn")
@onready var game: Node2D = $".."

var move_direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var directionX := Input.get_axis("Character_Left", "Character_Right")
	var directionY := Input.get_axis("Character_Top", "Character_Bottom")

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
	if event.is_action_pressed("Character_Sword"):
		shoot()
