extends Node2D

enum PossibleAnimations {
	IDLE,
	ONSEN_GINETTE,
	ONSEN_MICHEL,
	ONSEN_PAUL,
	ONSEN_VERONIQUE
}

var animations_correspondances: Dictionary = {
	0: &"idle",
	1: &"onsen_ginette",
	2: &"onsen_michel",
	3: &"onsen_paul",
	4: &"onsen_veronique"
}

@export_group("Monkey Properties")
@export
var monkey_name: String
@export
var monkey_number: int
@export
var monkey_animation: PossibleAnimations
@export
var monkey_is_intruder: bool

var mouse_on_monkey: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var proportion: float = (global_position[1] - (1080 - 335)) / 335
	var scale_to_apply = 0.65 + proportion * 0.45
	if global_position[1] < (1080 - 335):
		scale = Vector2(0.65, 0.65)
	else:
		scale =  Vector2(scale_to_apply, scale_to_apply)
	$AnimatedSprite2D.play(animations_correspondances[monkey_animation], 1.0)
	if monkey_is_intruder:
		PlayerVariables.intruder_monkey_number = monkey_number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	scale *= 1.05
	mouse_on_monkey = true


func _on_area_2d_mouse_exited() -> void:
	scale *= 0.95
	mouse_on_monkey = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			modulate = Color(Color.AZURE, 0.2)
			PlayerVariables.player_clicked_monkey.emit(monkey_number, true)


func _input(event: InputEvent) -> void:
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.is_pressed() and mouse_on_monkey == false
		):
		modulate = Color(1, 1, 1, 1)
		PlayerVariables.player_clicked_monkey.emit(monkey_number, false)
		
