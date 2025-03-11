extends Node2D

func _ready():
	$AnimatedSprite2D.play(&"default")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		PlayerVariables.emit_signal("transition_done")
