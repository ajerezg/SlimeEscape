extends CharacterBody2D

class_name Player

@export var get_hit_state: PlayerState
@export var hitbox_component: HitboxComponent
@export var health_component: HealthComponent
@export var invulnerability_duration := 1.0
@export var respawn_global_position := Vector2.ZERO

@onready var player_body_sprite_2d: Sprite2D = $PlayerBodySprite2D
@onready var player_animation_player = $PlayerAnimationPlayer

@onready var movement_state_machine = $MovementStateMachine
@onready var ground_state = $MovementStateMachine/GroundState

@onready var attack_state_machine: PlayerAttackStateMachine = $AttackStateMachine
@onready var idle_state: PlayerIdleAttackState = $AttackStateMachine/IdleState

@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@onready var label: Label = $Label

var main_scene : Node2D

@export var gravity := 980.0
@export var speed := 300.0
@export var jump_velocity := -450.0
@export var wall_slide_velocity := 150.0
var last_active_direction := Vector2.RIGHT
var is_invulnerable := false

# TODO: erase these testing vars
var basic_melee_attack_state := preload("res://player/basic_attack_state.tscn").instantiate()
var basic_range_attack_state := preload("res://player/basic_range_attack_state.tscn").instantiate()

func _ready() -> void:
	invulnerability_timer.one_shot = true
	invulnerability_timer.wait_time = invulnerability_duration
	main_scene = self.get_parent()
	movement_state_machine.current_state = ground_state
	attack_state_machine.current_state = idle_state
	#Initialize player movement states
	for child in movement_state_machine.get_children():
		child.player = self
		child.sprite_2d = player_body_sprite_2d
		child.animation_player = player_animation_player
	#Initialize player attack states
	for child in attack_state_machine.get_children():
		child.player = self
	# TODO: erase these testing adds
	
	self.add_secondary_attack(basic_range_attack_state)
	self.add_primary_attack(basic_melee_attack_state)

func _physics_process(delta: float) -> void:
	# Overwrite the hitbox_detection
	update_label()
	if !invulnerability_timer.is_stopped():
		hitbox_component.monitorable = false
		# TODO: add animation to indicate invulnerability.
	get_attack_direction()
	movement_state_machine.run_state(delta)
	attack_state_machine.run_state(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)
	attack_state_machine.process_input(event)


func jump() -> void:
	velocity.y = jump_velocity


func fall(delta, speed_factor=1) -> void:
	velocity.y += gravity * delta * speed_factor


func wall_slide(speed_factor=1) -> void:
	velocity.y = wall_slide_velocity * speed_factor


func move_x_axis(direction: float, speed_factor:=1.0):
	if direction:
		velocity.x = direction * speed * speed_factor
	else:
		velocity.x = move_toward(velocity.x, 0, speed/2)
	

func get_relative_mouse_position(normalize:bool = false):
	var relative_position = get_global_mouse_position() - global_position
	if normalize:
		relative_position = relative_position.normalized()
	return relative_position


func get_current_movement_state():
	return movement_state_machine.current_state


func get_current_attack_state():
	return attack_state_machine.current_state


func add_primary_attack(new_attack_state: PlayerAttackState):
	# TODO: delete previous attack of the same type
	new_attack_state.player = self
	new_attack_state.idle_state = idle_state
	attack_state_machine.add_child(new_attack_state)
	idle_state.primary_attack_state = new_attack_state

func add_secondary_attack(new_attack_state: PlayerAttackState):
	# TODO: delete previous attack of the same type
	new_attack_state.player = self
	new_attack_state.idle_state = idle_state
	attack_state_machine.add_child(new_attack_state)
	idle_state.secondary_attack_state = new_attack_state
	
func get_attack_direction() -> Vector2:	
	return _get_attack_direction_by_movement()

func _get_attack_direction_by_movement() -> Vector2:
	var direction := Vector2(Input.get_axis("left", "right"), 
							 Input.get_axis("up", "down"))
	if direction == Vector2.ZERO:
		direction = last_active_direction
	else:
		last_active_direction = direction
	return direction + global_position

func _get_attack_direction_by_mouse() -> Vector2:
	return get_global_mouse_position()


func get_hit(damage: float):
	invulnerability_timer.start()
	movement_state_machine.current_state.next_state = get_hit_state
	health_component.get_hit(damage)

func get_killed():
	global_position = respawn_global_position
	health_component.health = health_component.MAX_HEALTH

func set_checkpoint(position: Vector2) -> void:
	respawn_global_position = position

func update_label():
	label.text = str(health_component.health)
