extends Node2D

enum PossibleActions {
	IDLE,
	CAILLOU,
	GROOMING,
	ONSEN,
	PATATE
}

var click_sounds: Array[Node]

@export_group("Monkey Properties")
@export
var monkey_action: PossibleActions
@export
var monkey_name: PlayerVariables.PossibleNames
@export
var monkey_is_intruder: bool

var mouse_on_monkey: bool = false
var monkey_selected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# scale the monkey depending on its y position
	var proportion: float = (global_position[1] - (1080 - 335)) / 335
	var scale_to_apply = 0.65 + proportion * 0.45
	if global_position[1] < (1080 - 335):
		scale = Vector2(0.65, 0.65)
	else:
		scale =  Vector2(scale_to_apply, scale_to_apply)
	# play animation
	$AnimatedSprite2D.play(&"%s_%s" % [PossibleActions.keys()[monkey_action].to_lower(),
			PlayerVariables.PossibleNames.keys()[monkey_name].to_lower()], 1.0)
	# register intruder
	if monkey_is_intruder:
		PlayerVariables.intruder_monkey = monkey_name
	# register the sounds to play on click
	click_sounds = $ClickSounds.get_children()
	# play action sound
	if monkey_action == PossibleActions.CAILLOU:
		$ActionsSounds/SoundCaillou.play()
	elif monkey_action == PossibleActions.GROOMING:
		$ActionsSounds/SoundGrooming.play()
	elif monkey_action == PossibleActions.PATATE:
		$ActionsSounds/SoundPatate.play()

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
		if (
			event is InputEventMouseButton 
			and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
			):
			modulate = Color(1, 1, 1, 0.2)
			monkey_selected = true
			PlayerVariables.player_clicked_monkey.emit(monkey_name, true)
			click_sounds[randi() % len(click_sounds)].play()


func _input(event: InputEvent) -> void:
	if monkey_selected:
		if (
			event is InputEventMouseButton 
			and event.button_index == MOUSE_BUTTON_LEFT 
			and event.is_pressed() and mouse_on_monkey == false
			and PlayerVariables.mouse_on_rope == false
			):
			modulate = Color(1, 1, 1, 1)
			PlayerVariables.player_clicked_monkey.emit(monkey_name, false)
		
