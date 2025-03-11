extends Node2D

@export var nb_level = 4
var current_level = 1
const level_path = "res://levels/level_"
const intro_path = "res://game/transitions/transition"
const end_path = "res://game/end.tcsn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals
	PlayerVariables.next_level.connect(_on_next_level)
	PlayerVariables.replay_level.connect(_on_replay_level)
	PlayerVariables.transition_done.connect(_on_end_transition)
	PlayerVariables.play_music.connect(_on_play_music)
	PlayerVariables.stop_music.connect(_on_stop_music)
	
	# Launch first level
	load_intro(current_level)


func load_level(i: int):
	var path = level_path + str(i) + "/stage_" + str(i) + ".tscn"
	var scene: PackedScene = load(path)
	add_child(scene.instantiate())

func load_intro(i: int):
	_on_stop_music()
	var path = intro_path + str(i) + ".tscn"
	var scene: PackedScene = load(path)
	add_child(scene.instantiate())


func clean_manager():
	var child = get_child(1)
	child.queue_free()
	
func _on_next_level():
	print(current_level, " ", nb_level)
	if current_level == nb_level:
		get_tree().change_scene_to_file("res://game/end.tscn")
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

func _on_play_music(type: String, variation: String):
	$MusicManager.play(type, variation)

func _on_stop_music():
	$MusicManager.clean_tree()
	
