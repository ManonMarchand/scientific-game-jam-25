extends Node2D

@export var nb_level = 4
var current_level = 1
const level_path = "res://levels/level_"
const intro_path = "res://game/transitions/transition"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals
	PlayerVariables.next_level.connect(_on_next_level)
	PlayerVariables.replay_level.connect(_on_replay_level)
	PlayerVariables.transition_done.connect(_on_end_transition)
	
	# Launch first level
	load_intro(current_level)


func load_level(i: int):
	var path = level_path + str(i) + "/stage_" + str(i) + ".tscn"
	var scene: PackedScene = load(path)
	add_child(scene.instantiate())

func load_intro(i: int):
	var path = intro_path + str(i) + ".tscn"
	print(path)
	var scene: PackedScene = load(path)
	print(scene)
	add_child(scene.instantiate())


func clean_manager():
	var child = get_child(0)
	child.queue_free()
	
func _on_next_level():
	if current_level == nb_level:
		pass  # écran de fin
		return
	clean_manager()
	current_level += 1
	load_intro(current_level)
	
func _on_replay_level():
	clean_manager()
	load_intro(current_level)

func _on_end_transition():
	clean_manager()
	load_level(current_level)
	
