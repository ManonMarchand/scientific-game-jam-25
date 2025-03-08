extends Node2D

var is_animating_up = false
var is_animating_down = false
var anim_current_time = 0.
@export
var anim_total_time = 0.5

func _process(delta: float) -> void:
	if is_animating_down:
		anim_current_time += delta
		if anim_current_time >= anim_total_time:
			$Path2D/PathFollow2D.progress_ratio = 1
			is_animating_down = false
		else:
			$Path2D/PathFollow2D.progress_ratio = anim_current_time/anim_total_time

	if is_animating_up:
		anim_current_time -= delta
		if anim_current_time <= 0:
			$Path2D/PathFollow2D.progress_ratio = 0
			is_animating_up = false
		else:
			$Path2D/PathFollow2D.progress_ratio = anim_current_time/anim_total_time
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Path2D.curve.add_point(Vector2(0,0))
	$Path2D.curve.add_point(-$Path2D/PathFollow2D/DiagramPanel.transform.origin)


func _on_rope_panel_go_down() -> void:
	anim_current_time = 0.
	is_animating_down = true
	

func _on_rope_panel_go_up() -> void:
	anim_current_time = anim_total_time
	is_animating_up = true
