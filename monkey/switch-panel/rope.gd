extends Node2D

signal panel_go_down
signal panel_go_up

var is_down: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		_on_button_pressed()

func _on_button_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)

func _on_button_mouse_exited() -> void:
	scale = Vector2(1, 1)


func _on_button_pressed() -> void:
	if is_down:
		panel_go_up.emit()
		is_down = false
	else:
		panel_go_down.emit()
		is_down = true
