extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		PlayerVariables.emit_signal("replay_level")
		
func _ready() -> void:
	$SonDefaite.play()
		
