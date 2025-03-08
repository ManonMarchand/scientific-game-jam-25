@tool
class_name DiagramNode

extends StaticBody2D

@export
var is_trespaser_node: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not is_trespaser_node:
		$ColorRect.modulate = Color(Color.AQUAMARINE, 0.5)
	else:
		$ColorRect.modulate = Color(Color.CRIMSON, 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
