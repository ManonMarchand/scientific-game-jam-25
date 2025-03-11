extends Node

var is_player_dragging: bool = false
var intruder_monkey_number: int = 0

signal player_clicked_monkey(monkey_number: int, select: bool)

signal layton_event(monkey_identified: bool)

signal next_level()
signal replay_level()

signal transition_done()

signal play_music(type: String, variation: String)
signal stop_music()
