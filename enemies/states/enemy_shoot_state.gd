extends AbstractEnemyMovementState

class_name EnemyShootState

@export var ground_state : AbstractEnemyMovementState
@export var cooldown_time := 0.8
@export var range_detector : Area2D
@export var projectile_scene : Resource

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle_position: Marker2D = $MuzzlePosition


var target_global_position := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.one_shot = true
	cooldown_timer.wait_time = cooldown_time


func run(delta):
	animation_player.play("shoot")
	if cooldown_timer.is_stopped():
		if can_enter_middle_run():
			next_state = self
		else:
			next_state = ground_state

func can_enter_middle_run():
	return (enemy.is_on_floor() and is_player_in_range() and cooldown_timer.is_stopped())

func on_enter():
	enemy.stop_x()
	cooldown_timer.start()
	muzzle_position.global_position = enemy.global_position
	shoot_projectile()

func on_exit():
	enemy.move_x()

func is_player_in_range(set_target_position:= true):
	for area in range_detector.get_overlapping_areas():
		if area.is_in_group("player_hitbox") and area is HitboxComponent:
			if set_target_position:
				target_global_position = area.entity.global_position
			return true
	return false

func shoot_projectile():
	print(str(target_global_position))
	print(str(muzzle_position.global_position))
	muzzle_position.look_at(target_global_position)
	var new_projectile = projectile_scene.instantiate()
	new_projectile.spawn_position = muzzle_position.global_position
	new_projectile.spawn_rotation = muzzle_position.rotation
	new_projectile.direction = muzzle_position.rotation
	enemy.get_parent().add_child.call_deferred(new_projectile)
