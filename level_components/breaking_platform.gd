extends StaticBody2D

@export var deactivation_time := 2.0
@export var respawn_time := 5.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var deactivation_timer: Timer = $DeactivationTimer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var area_2d: Area2D = $Area2D

var active := true
var original_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deactivation_timer.one_shot = true
	deactivation_timer.wait_time = deactivation_time
	respawn_timer.one_shot = true
	respawn_timer.wait_time = respawn_time
	original_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if respawn_timer.is_stopped():
			sprite_2d.position = Vector2.ZERO
			sprite_2d.visible = true
			sprite_2d.frame_coords = Vector2(48, 14)
			collision_shape_2d.disabled = false
			area_2d.monitoring = true
		else:
			sprite_2d.visible = false
			collision_shape_2d.disabled = true
			area_2d.monitoring = false
	elif !active:
		if deactivation_timer.is_stopped():
			sprite_2d.visible = false
			collision_shape_2d.disabled = true
			area_2d.monitoring = false
			activate()
		else:
			sprite_2d.visible = true
			collision_shape_2d.disabled = false
			area_2d.monitoring = false
			sprite_2d.frame_coords = Vector2(48, 21)
			sprite_2d.position = Vector2(randf_range(-1, 1), randf_range(-1, 1))

func activate():
	active = true
	respawn_timer.start()

func deactivate():
	active = false
	deactivation_timer.start()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player in platform!")
		deactivate()
