extends Node

# Dealing with mouse behavior
var is_player_dragging: bool = false
var mouse_on_rope: bool = false
signal player_clicked_monkey(monkey_number: int, select: bool)

# Scenes events
signal layton_event(monkey_identified: bool)
signal next_level()
signal replay_level()
signal transition_done()

# General events
signal play_music(type: String, variation: String)
signal stop_music()

# Monkey properties
var intruder_monkey: PossibleNames
enum PossibleNames {
	GINETTE,
	JACQUES,
	JEAN,
	MICHEL,
	PAUL,
	VERONIQUE
}
