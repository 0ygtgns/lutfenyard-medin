extends RigidBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	var is_sword_active = Input.is_action_just_pressed("Character_Sword")
	if is_sword_active:
		animation_player.play("sword_flip")
		linear_velocity.x = 130
