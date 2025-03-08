extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.color = Color(Color.AQUAMARINE, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
