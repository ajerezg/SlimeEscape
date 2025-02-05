extends CharacterBody2D

class_name BasicRangeProjectile

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var duration_timer: Timer = $DurationTimer
@onready var impact_timer: Timer = $ImpactTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var hit_sound := preload("res://hit1.ogg")
@export var damage := 5.0
@export var speed := 500.0
@export var duration_time := 2.0
@export var impact_time := 0.3

var has_impacted = false
var direction: float
var spawn_position: Vector2
var spawn_rotation: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation
	duration_timer.one_shot = true
	duration_timer.wait_time = duration_time
	duration_timer.start()
	impact_timer.one_shot = true
	impact_timer.wait_time = impact_time
	velocity = Vector2(speed,0).rotated(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_impacted and impact_timer.is_stopped():
		self.queue_free()
	elif !has_impacted and (duration_timer.is_stopped() or is_on_ceiling() or
			is_on_floor() or is_on_wall()):
		impact()
	elif !has_impacted:
		animation_player.play("shooting")
		move_and_slide()

func impact():
	has_impacted = true
	impact_timer.start()
	animation_player.play("impacting")
	velocity = Vector2.ZERO

func _on_hurt_box_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_hitbox") and area is HitboxComponent:
		area.get_hit(damage)
		audio_stream_player_2d.set_stream(hit_sound)
		audio_stream_player_2d.play()
		impact()
