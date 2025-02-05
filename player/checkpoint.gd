extends Node2D


@onready var respawn_point_marker: Marker2D = $RespawnPointMarker
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var upper_sprite_2d: Sprite2D = $UpperSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func activate():
	sprite_2d.frame_coords = Vector2(48, 10)
	upper_sprite_2d.frame_coords = Vector2(48, 10)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entering")
	if body is Player:
		print("player entered")
		body.set_checkpoint(respawn_point_marker.global_position)
		activate()
