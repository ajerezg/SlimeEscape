extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var duration_timer: Timer = $DurationTimer

var speed := 500.0
var duration_time := 2.0

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(direction)
	animation_player.play("shooting")
	move_and_slide()
	if duration_timer.is_stopped():
		self.queue_free()
