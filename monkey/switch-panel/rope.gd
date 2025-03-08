extends Node2D

signal panel_go_down
signal panel_go_up

var is_down: bool = false
var can_click: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_panel"):
		rope_pressed()

func _input(event: InputEvent) -> void:
	if can_click:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			rope_pressed()

func rope_pressed() -> void:
	if is_down:
		panel_go_up.emit()
		is_down = false
	else:
		panel_go_down.emit()
		is_down = true


func _on_mouse_exited() -> void:
	scale = Vector2(1., 1.)
	can_click = false


func _on_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	can_click = true
