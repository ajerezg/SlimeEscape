@tool
extends Node2D
class_name CameraArea2DComponent

@export var debug_color = Color(0.032, 0.48, 0.026, 0.471)
@export var shape: Rect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()
	else:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	if Engine.is_editor_hint():
		if shape:
			draw_rect(shape, debug_color)
	else:
		pass

func is_point_inside_shape(point: Vector2) -> bool:
	if (shape.position.x <= point.x and point.x <= shape.end.x) and (
			shape.position.y <= point.y and point.y <= shape.end.y):
		return true
	return false
