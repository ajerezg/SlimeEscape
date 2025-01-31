extends PlayerAttackState

@export var attack_state: PlayerAttackState


func run(delta):
	pass

func process_input(event: InputEvent):
	if attack_state.can_enter(event):
		next_state = attack_state
