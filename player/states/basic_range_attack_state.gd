extends PlayerAttackState

@onready var attack_timer: Timer = $AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_center_position: Marker2D = $PlayerCenterPosition
@onready var sprite_2d: Sprite2D = $PlayerCenterPosition/Sprite2D
@onready var muzzle_position: Marker2D = $PlayerCenterPosition/MuzzlePosition

var projectile_scene := preload("res://player/basic_range_projectile.tscn")
var attack_time := 0.4


func _ready() -> void:
	attack_timer.one_shot = true


func can_enter(event: InputEvent):
	if event.is_action_pressed("secondary_attack"):
		return true
	return false


func on_enter():
	player_center_position.position = player.position
	attack_timer.wait_time = attack_time
	attack_timer.start()
	player_center_position.look_at(player.get_attack_direction())
	var new_projectile = projectile_scene.instantiate()
	new_projectile.spawn_position = muzzle_position.global_position
	new_projectile.spawn_rotation = player_center_position.rotation
	new_projectile.direction = player_center_position.rotation
	player.main_scene.add_child.call_deferred(new_projectile)
	

func run(delta):
	player_center_position.position = player.position
	if !attack_timer.is_stopped():
		animation_player.play("attack")
	else:
		next_state = idle_state
		animation_player.play("idle")
