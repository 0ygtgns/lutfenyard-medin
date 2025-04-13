extends RigidBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_node = get_node_or_null("character")

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	var animated_sprite = character_node.get_node("AnimatedSprite2D")
	var is_sword_active_character = Input.is_action_just_pressed("Character_Sword")
	if is_sword_active_character and animated_sprite.flip.h == 0:
		visible = true
		animation_player.play("sword_flip")
		linear_velocity.x = 350
	elif is_sword_active_character and animated_sprite.flip.h == 1:
		visible = true
		animation_player.play("sword_flip")
		linear_velocity.x = -350
		
		
		
		
			
		
