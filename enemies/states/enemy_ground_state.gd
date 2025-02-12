extends AbstractEnemyMovementState

class_name EnemyMovementGroundState

@export var air_state: AbstractEnemyMovementState
@export var shoot_state: AbstractEnemyMovementState
@export var animation_name := "walk"
@export var avoid_fall: bool = false
@export var ray_cast_left: RayCast2D 
@export var ray_cast_right: RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func run(delta):
	animation_player.play(animation_name)
	#print("enemy.direction: " + str(sign(enemy.direction.x)))
	#print("enemy.wall_normal: " + str(sign(enemy.get_wall_normal().x)))
	
	if avoid_fall and (ray_cast_left.is_colliding() != ray_cast_right.is_colliding()):
		enemy.direction.x = -enemy.direction.x
	enemy.bounce_on_wall()
	if air_state.can_enter_middle_run():
		next_state = air_state
	elif shoot_state and shoot_state.can_enter_middle_run():
		next_state = shoot_state

func can_enter_middle_run():
	return enemy.is_on_floor()

func on_exit():
	pass

func on_enter():
	pass
