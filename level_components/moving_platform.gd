extends PathFollow2D

@export var progress_per_second_ratio := 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += progress_per_second_ratio * delta
	pass
