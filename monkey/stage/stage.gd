extends Node2D

@export var player_offset_on_arrival = 150
@export var playable_width = 380
@export var substage_list: Array[PackedScene]

var nb_substage: int = 0
var current_stage_index
var win_screen: PackedScene
var lose_screen: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect win signal
	PlayerVariables.layton_event.connect(_on_guess)
	# Load win and lose scenes
	win_screen = load("res://game/layton_win.tscn")
	lose_screen = load("res://game/layton_lose.tscn")
	# Init player
	$Player.set_screen(Vector2(0, 1080-playable_width), Vector2(1920, playable_width))
	$Player.position.y = 1080-playable_width/2  
	nb_substage = len(substage_list)
	init_substage(0, true)


func init_substage(stage_index: int, from_left: bool):
	current_stage_index = stage_index
	# Remove current substage if necessary
	var substage_node = get_node_or_null("Substage")
	if substage_node != null:
		remove_child(substage_node)
	# Create new substage
	var new_substage = substage_list[stage_index].instantiate()
	new_substage.name = "Substage"
	new_substage.position = Vector2.ZERO
	add_child(new_substage)
	# Move player
	if from_left:
		$Player.position.x = player_offset_on_arrival
	else:
		$Player.position.x = get_viewport_rect().size.x - player_offset_on_arrival
	# Play music
	PlayerVariables.play_music.emit(
		new_substage.get_music_type_str(),
		new_substage.get_music_variation_str()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var substage = get_node_or_null("Substage")
	if substage != null:
		var monkey_list: Node = substage.get_node("MonkeyList")
		print("a")
		for monkey in monkey_list.get_children():
			print(monkey.get_node("Floor").position.y, " ", $Player/Floor.position.y)
			if monkey.position.y + monkey.get_node("Floor").position.y < $Player.position.y + $Player/Floor.position.y:
				monkey.z_index = 0
			else:
				monkey.z_index = 1


func _on_player_leave_left() -> void:
	if current_stage_index == 0:
		return
	init_substage(current_stage_index - 1, false)

func _on_player_leave_right() -> void:
	if current_stage_index == nb_substage - 1:
		return
	init_substage(current_stage_index + 1, true)

func _on_guess(is_win: bool):
	# Create right node
	var scene_to_load: CanvasItem
	if is_win:
		scene_to_load = win_screen.instantiate()
	else:
		scene_to_load = lose_screen.instantiate()
	# Put scene in front
	scene_to_load.z_index = 20
	# Add scene
	add_child(scene_to_load)
