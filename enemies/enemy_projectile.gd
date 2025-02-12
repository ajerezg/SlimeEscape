extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var duration_timer: Timer = $DurationTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var impacting_timer: Timer = $ImpactingTimer

@export var damage := 2.0
@export var speed := 100.0
@export var duration_time := 2.0
@export var impacting_time := 0.4

var direction: float
var spawn_position: Vector2
var spawn_rotation: float
var has_impacted := false

func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation
	duration_timer.one_shot = true
	duration_timer.wait_time = duration_time
	duration_timer.start()
	impacting_timer.one_shot = true
	impacting_timer.wait_time = impacting_time
	velocity = Vector2(speed,0).rotated(direction)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if has_impacted and impacting_timer.is_stopped():
		queue_free()
	elif !has_impacted and must_impact():
		impact()
	elif !has_impacted:
		animation_player.play("shooting")
		move_and_slide()

func must_impact():
	return is_on_ceiling() or is_on_floor() or is_on_wall() or duration_timer.is_stopped()

func impact():
	has_impacted = true
	impacting_timer.start()
	animation_player.play("impacting")
	velocity = Vector2.ZERO


func _on_hurt_box_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox") and area is HitboxComponent:
		area.get_hit(damage)
		impact()
