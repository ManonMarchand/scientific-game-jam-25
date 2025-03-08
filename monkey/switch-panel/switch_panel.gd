extends Node2D

@export var anim_total_time = 0.5
# TODO: il faut mettre la vraie bonne scène à cet endroit
@export var panel_scene: PackedScene

var is_animating_up = false
var is_animating_down = false
var anim_current_time = 0.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create panel scene
	var panel = panel_scene.instantiate()
	panel.name = "Panel"
	panel.transform.origin += Vector2(0, -900)
	$Path2D/PathFollow2D.add_child(panel)
	# Create path
	$Path2D.curve.add_point(Vector2(0,0))
	$Path2D.curve.add_point(-$Path2D/PathFollow2D/Panel.transform.origin)


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


func _on_rope_panel_go_down() -> void:
	anim_current_time = 0.
	is_animating_down = true
	

func _on_rope_panel_go_up() -> void:
	anim_current_time = anim_total_time
	is_animating_up = true
