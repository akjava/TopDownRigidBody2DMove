extends RigidBody2D

export(int) var TURN_SPEED = 1

var MOVE_SPEED = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func lookAtNode(node, delta):
	var angle = get_angle_to(node.global_position)
	set_angular_velocity(angle / delta)


func _integrate_forces(state):
	var player = get_tree().current_scene.get_node("Player")
	lookAtNode(player, state.get_step() * TURN_SPEED)
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	state.set_linear_velocity(vec_to_player * MOVE_SPEED)
