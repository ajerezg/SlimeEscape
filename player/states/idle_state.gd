extends PlayerAttackState

class_name PlayerIdleAttackState

@export var primary_attack_state: PlayerAttackState
@export var secondary_attack_state: PlayerAttackState


func run(delta):
	pass

func process_input(event: InputEvent):
	if primary_attack_state != null and primary_attack_state.can_enter(event):
		next_state = primary_attack_state
	elif secondary_attack_state != null and secondary_attack_state.can_enter(event):
		next_state = secondary_attack_state
