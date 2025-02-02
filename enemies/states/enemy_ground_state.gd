extends AbstractEnemyMovementState


@export var air_state: AbstractEnemyMovementState



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func run(delta):
	animation_player.play("walk")
	#print("enemy.direction: " + str(sign(enemy.direction.x)))
	#print("enemy.wall_normal: " + str(sign(enemy.get_wall_normal().x)))
	crash_on_wall()
	if air_state.can_enter_middle_run():
		next_state = air_state

func can_enter_middle_run():
	return enemy.is_on_floor()
