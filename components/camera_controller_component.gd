extends Node

@export var player: Player
@export var camera: Camera2D
@export var camera_area_components: Array[CameraArea2DComponent]

var current_camera_area_component: CameraArea2DComponent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for camera_area_component in camera_area_components:
		if camera_area_component.is_point_inside_shape(player.position):
			current_camera_area_component = camera_area_component
			# TODO: set camera limits
			var shape := camera_area_component.shape
			camera.limit_top = shape.position.y
			camera.limit_left = shape.position.x
			camera.limit_bottom = shape.end.y
			camera.limit_right = shape.end.x
	camera.position = player.position
