extends Node2D

enum MusicType {
	JUNGLE,
	NEIGE,
}

enum MusicVariation {
	BASE,
	PIANO,
	VIOLONS,
}

@export_group("Music")
@export var music_type: MusicType
@export var music_variation: MusicVariation

func get_music_type_str() -> String:
	return MusicType.keys()[music_type]
	
func get_music_variation_str() -> String:
	return MusicVariation.keys()[music_variation]
