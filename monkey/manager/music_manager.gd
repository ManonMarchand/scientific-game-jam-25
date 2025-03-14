extends Node

const MUSIC_PATH = "res://assets/sounds/ambiance"
var music_dict = {}

var current_type = null
var current_variation = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load the musics
	var music_dir: DirAccess = DirAccess.open(MUSIC_PATH)
	if music_dir == null:
		print("Could not open music folder")
		return
	for file: String in music_dir.get_files():
		var extsplit = file.split(".")
		var filename = extsplit[0]
		var ext = extsplit[1]
		if len(extsplit) != 3 or ext != "wav" or extsplit[2] != "import":
			continue
		var file_to_load = filename + "." + ext
		# Create new player
		var music_path = MUSIC_PATH + "/" + file_to_load
		var player = AudioStreamPlayer.new()
		var stream = load(music_path)
		player.stream = stream
		
		# Put player in dict
		var file_param = filename.split("_")
		var type = file_param[1]
		var variation = file_param[2]
		if type not in music_dict:
			music_dict[type] = {}
		music_dict[type][variation] = player


func clean_tree():
	for player: AudioStreamPlayer in get_children():
		player.stop()
		remove_child(player)
	current_type = null
	current_variation = null

func play(type: String, variation: String):
	if type == current_type and variation == current_variation:
		return
	# load new set of player if necessary
	if  current_type != type:
		clean_tree()
		for player: AudioStreamPlayer in music_dict[type].values():
			if player == music_dict[type]["BASE"]:
				player.volume_db = 0
			else:
				player.volume_db = -INF
			add_child(player)
			player.play()
	else:
		# Mute all non base
		for player: AudioStreamPlayer in get_children():
			if player != music_dict[type]["BASE"]:
				player.volume_db = -INF
	
	# Play right variation
	for player: AudioStreamPlayer in get_children():
		if player != music_dict[type]["BASE"] and player == music_dict[type][variation]:
			player.volume_db = 0
	
	# Update current variables
	current_type = type
	current_variation = variation
