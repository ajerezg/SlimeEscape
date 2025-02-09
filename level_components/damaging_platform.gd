extends StaticBody2D

@export var damage := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hurt_box_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox") and area is HitboxComponent:
		area.get_hit(damage)
