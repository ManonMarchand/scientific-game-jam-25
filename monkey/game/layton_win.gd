extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		PlayerVariables.emit_signal("next_level")
		
func _ready() -> void:
	$SonVictoire.play()
