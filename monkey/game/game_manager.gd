extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event is InputEventKey and event.is_released() and event.physical_keycode == KEY_F:
		var window := get_viewport().get_window()
		window.mode = (
			Window.MODE_FULLSCREEN if window.mode != Window.MODE_FULLSCREEN
			else Window.MODE_WINDOWED
		)
