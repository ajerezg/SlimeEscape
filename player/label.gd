extends Label

class_name PlayerLabel


var player: Player


func _process(delta: float) -> void:
	var current_state_name = player.movement_state_machine.current_state.get_name_str()
	text = current_state_name
