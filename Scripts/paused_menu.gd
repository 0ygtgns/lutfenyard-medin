extends Control

func resume():
	get_tree().paused = false
	hide()
func pause():
	get_tree().paused = true
	show()

func testesc():
	if Input.is_action_just_pressed("esc") and get_tree().paused== false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _ready() -> void:
	get_tree().paused = false
	hide()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	hide()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().paused= false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _process(delta: float) -> void:
	testesc()
	
