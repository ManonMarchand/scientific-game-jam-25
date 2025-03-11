extends Node2D

signal panel_go_down
signal panel_go_up

var is_down: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_panel"):
		rope_pressed()

func _input(event: InputEvent) -> void:
	if PlayerVariables.mouse_on_rope:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			rope_pressed()
			

func rope_pressed() -> void:
	$SonInterfaceLianeLachage.play()
	if is_down:
		panel_go_up.emit()
		is_down = false
	else:
		panel_go_down.emit()
		is_down = true


func _on_mouse_exited() -> void:
	scale = Vector2(1., 1.)
	PlayerVariables.mouse_on_rope = false


func _on_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	$SonInterfaceLianePriseEnMain.play()
	PlayerVariables.mouse_on_rope = true
	
