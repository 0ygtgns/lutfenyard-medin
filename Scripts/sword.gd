extends RigidBody2D

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	var is_sword_active = Input.is_action_just_pressed("Character_Sword")
	if is_sword_active:
		var linear_velocity = 130
