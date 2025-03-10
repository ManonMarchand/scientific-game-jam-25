extends Node2D

signal restart_game

func _ready():
	$Label.visible = false

func _input(event: InputEvent) -> void:
	if $Timer.is_stopped():
		if event is InputEventKey:
			if event.pressed:
				get_tree().change_scene_to_file("res://game/intro.tscn")


func _on_timer_timeout() -> void:
	$Label.visible = true
