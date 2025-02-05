extends AbstractEnemy

class_name EnemyRat

@export var health_component: HealthComponent
@export var get_hit_state: AbstractEnemyMovementState
@export var get_killed_state: AbstractEnemyMovementState

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_movement_state_machine: EnemyMovementStateMachine = $EnemyMovementStateMachine
@onready var enemy_air_state: Node = $EnemyMovementStateMachine/EnemyAirState
@onready var label: Label = $Label


func _ready() -> void:
	velocity.x = speed * direction.x
	enemy_movement_state_machine.current_state = enemy_air_state
	for child in enemy_movement_state_machine.get_children():
		child.enemy = self
		child.sprite_2d = sprite_2d
		child.animation_player = animation_player

func _physics_process(delta: float) -> void:
	label.text = str(health_component.health) + " " + enemy_movement_state_machine.current_state.name
	enemy_movement_state_machine.run_state(delta)
	#attack_state_machine.run_state(delta)
	move_and_slide()

func get_hit(damage: float):
	enemy_movement_state_machine.current_state.next_state = get_hit_state
	health_component.get_hit(damage)

func get_killed():
	enemy_movement_state_machine.current_state.next_state = get_killed_state
