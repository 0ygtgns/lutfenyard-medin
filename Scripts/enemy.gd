extends CharacterBody2D
@onready var health_bar = $HealthBar
@export var SPEED = 130
@export var MAX_HEALTH = 100
var current_health = MAX_HEALTH
@onready var projectile = load("res://Scenes/sword1.tscn")
@onready var game: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var winner_page: Node2D = $"../winner_page"


var move_direction = Vector2.ZERO
var is_hit := false
var is_dead := false

func _ready() -> void:
	add_to_group("enemy")
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	if is_hit or is_dead:
		return  # Skip movement during hit/death animations
		
	var directionX := Input.get_axis("Enemy_Left", "Enemy_Right")
	var directionY := Input.get_axis("Enemy_Top", "Enemy_Bottom")

	move_direction = Vector2(directionX, directionY).normalized()
	velocity = move_direction * SPEED

	if move_direction.length_squared() > 0:
		rotation = move_direction.angle()
		animated_sprite_2d.play("move")
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()

func shoot():
	# YOUR ORIGINAL SHOOT FUNCTION EXACTLY AS YOU HAD IT
	var instance = projectile.instantiate()
	instance.movement_direction = move_direction.normalized()  # Pass Vector2 directly
	instance.spawnPos = global_position
	game.add_child.call_deferred(instance)

func _input(event: InputEvent) -> void:
	# YOUR ORIGINAL INPUT FUNCTION EXACTLY AS YOU HAD IT
	if event.is_action_pressed("Enemy__Sword"):
		shoot()

func take_damage(amount):
	if is_hit or is_dead:
		return
		
	current_health -= amount
	health_bar.value = current_health
	is_hit = true
	animated_sprite_2d.play("hit")
	await animated_sprite_2d.animation_finished
	is_hit = false
	
	if current_health <= 0:
		die()
		winner_page.winner_character()
	else:
		# Return to appropriate animation after hit
		if move_direction.length_squared() > 0:
			animated_sprite_2d.play("move")
		else:
			animated_sprite_2d.play("idle")

func die():
	is_dead = true
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
	queue_free()
