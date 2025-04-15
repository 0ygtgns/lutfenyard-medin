extends CharacterBody2D
@onready var health_bar = $HealthBar
@export var SPEED = 130
@export var MAX_HEALTH = 100
var current_health = MAX_HEALTH
@onready var projectile = load("res://Scenes/sword.tscn")
@onready var game: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var move_direction = Vector2.ZERO
var is_hit := false
var is_dead := false  # Added death state tracking

func _ready() -> void:
	add_to_group("player")
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	if is_hit or is_dead:  # Added is_dead check
		return
		
	var directionX := Input.get_axis("Character_Left", "Character_Right")
	var directionY := Input.get_axis("Character_Top", "Character_Bottom")

	move_direction = Vector2(directionX, directionY).normalized()
	velocity = move_direction * SPEED
	
	if velocity.length() > 0:
		animated_sprite_2d.play("run")
		rotation = move_direction.angle()
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()

# YOUR ORIGINAL SHOOT FUNCTION (UNCHANGED)
func shoot():
	var instance = projectile.instantiate()
	instance.movement_direction = move_direction.normalized()
	instance.spawnPos = global_position
	game.add_child.call_deferred(instance)

# YOUR ORIGINAL INPUT FUNCTION (UNCHANGED)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Character_Sword"):
		shoot()
		
func take_damage(amount):
	if is_hit or is_dead:  # Added is_dead check
		return
		
	current_health -= amount
	health_bar.value = current_health
	is_hit = true
	animated_sprite_2d.play("hit")
	await animated_sprite_2d.animation_finished
	is_hit = false
	
	if current_health <= 0:
		die()

# FIXED DIE FUNCTION (ONLY THIS WAS MODIFIED)
func die():
	is_dead = true  # Set death state
	animated_sprite_2d.play("death")
	# Disable collisions and input during death
	set_collision_mask_value(1, false)
	set_process_input(false)
	await animated_sprite_2d.animation_finished
	queue_free()
