extends PlayerAttackState

@onready var attack_timer: Timer = $AttackTimer
@onready var rest_timer: Timer = $RestTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $PlayerCenterPosition/Sprite2D
@onready var player_center_position: Marker2D = $PlayerCenterPosition
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var hit_sound = preload("res://hit2.ogg")
@export var damage := 10

var attack_time := 0.2
var rest_time := 0.4


func _ready() -> void:
	attack_timer.one_shot = true
	rest_timer.one_shot = true


func can_enter(event: InputEvent):
	if event.is_action_pressed("primary_attack"):
		return true
	return false


func on_enter():
	player_center_position.position = player.position
	attack_timer.wait_time = attack_time
	rest_timer.wait_time = attack_time + rest_time
	attack_timer.start()
	rest_timer.start()
	player_center_position.look_at(player.get_attack_direction())


func run(delta):
	player_center_position.position = player.position
	if !attack_timer.is_stopped():
		animation_player.play("attack")
	elif rest_timer.is_stopped():
		animation_player.play("idle")
		next_state = idle_state

func _on_hurt_box_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_hitbox") and area is HitboxComponent:
		area.get_hit(damage)
		audio_stream_player_2d.set_stream(hit_sound)
		audio_stream_player_2d.play()
