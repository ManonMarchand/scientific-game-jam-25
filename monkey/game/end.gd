extends Node2D

signal restart_game

func _input(event: InputEvent) -> void:
	if $Timer.is_stopped():
		if event is InputEventKey:
			if event.pressed:
				get_tree().change_scene_to_file("res://game/intro.tscn")
