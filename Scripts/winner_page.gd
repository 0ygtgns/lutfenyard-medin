extends Node2D

@onready var winner: Label = $winner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func winner_character():
	show()
	winner.text = "Knight is Winner"
	
	
func winner_enemy():
	show()
	winner.text = "Enemy is Winner"


func _on_restart_pressed() -> void:
	hide()
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	hide()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
