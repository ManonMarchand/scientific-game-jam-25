extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene_to_file("res://manager/manager.tscn")
