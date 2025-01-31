extends CharacterBody2D

class_name Player

@onready var player_body_sprite_2d: Sprite2D = $PlayerBodySprite2D
@onready var player_animation_player = $PlayerAnimationPlayer

@onready var movement_state_machine = $MovementStateMachine
@onready var ground_state = $MovementStateMachine/GroundState

@onready var attack_state_machine: PlayerAttackStateMachine = $AttackStateMachine
@onready var idle_state: Node = $AttackStateMachine/IdleState

@onready var label: PlayerLabel = $Label


var gravity := 980.0
var speed := 300.0
var jump_velocity := -450.0
var wall_slide_velocity := 150.0


func _ready() -> void:
	label.player = self
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


func _physics_process(delta: float) -> void:
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
		velocity.x = move_toward(velocity.x, 0, speed)


func get_relative_mouse_position(normalize:bool = false):
	var relative_position = get_global_mouse_position() - global_position
	if normalize:
		relative_position = relative_position.normalized()
	return relative_position
