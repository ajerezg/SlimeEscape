extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var duration_timer: Timer = $DurationTimer
@onready var impact_timer: Timer = $ImpactTimer

var speed := 500.0
var duration_time := 2.0
var has_impacted = false
var impact_time := 0.2

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
		has_impacted = true
		impact_timer.start()
		animation_player.play("impacting")
		velocity = Vector2.ZERO
	elif !has_impacted:
		animation_player.play("shooting")
		move_and_slide()
