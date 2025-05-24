extends Node3D

@export var animation_speed: float = 10.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

var run_path: String = "parameters/MoveSpace/blend_position"
var run_weight_target := -1.0


func _physics_process(delta: float) -> void:
	animation_tree[run_path] = move_toward(animation_tree[run_path], run_weight_target, delta * animation_speed)


func update_animation_tree(direction: Vector3) -> void:
	if direction.is_zero_approx():
		run_weight_target = -1.0
	else:
		run_weight_target = 1.0


func travel(animation_name: String) -> void:
	playback.travel(animation_name)


func is_idle() -> bool:
	return playback.get_current_node() == "MoveSpace"


func is_slashing() -> bool:
	return playback.get_current_node() == "Slash"
