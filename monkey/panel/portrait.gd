extends Node2D


var can_be_dragged: bool = false
var can_be_dropped: bool = false
var reference_to_body: Node2D
var offset: Vector2
var initial_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if can_be_dragged:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			initial_position = global_position
			offset = get_global_mouse_position() - global_position
			PlayerVariables.is_player_dragging = true
		if event is InputEventMouseMotion and PlayerVariables.is_player_dragging == true:
			global_position = get_global_mouse_position() - offset
		elif event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			PlayerVariables.is_player_dragging = false
			var tween : Tween = get_tree().create_tween()
			if can_be_dropped:
				tween.tween_property(self, "position", reference_to_body.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "position", initial_position, 0.2).set_ease(Tween.EASE_OUT)
			
		

func _on_area_2d_mouse_entered() -> void:
	if not PlayerVariables.is_player_dragging:
		can_be_dragged = true
		scale = Vector2(1.05, 1.05)
		
func _on_area_2d_mouse_exited() -> void:
	if not PlayerVariables.is_player_dragging:
		can_be_dragged = false
		scale = Vector2(1, 1)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		can_be_dropped = true
		body.modulate = Color.AQUAMARINE
		reference_to_body = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		can_be_dropped = false
		body.modulate = Color(Color.AQUAMARINE, 0.7)
