extends RigidBody2D

var bullet=preload("res://Bullet.tscn")
var fire

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# default are state.get_step(),speed are relative
func lookAtMouse(delta):
	var angle = get_angle_to(get_global_mouse_position())
	set_angular_velocity(angle / delta)


func _unhandled_input(event):
	# one time check
	if event.is_action_pressed("ui_shot"):
		fire = true	


func _integrate_forces(state):
	if fire:
		var b = bullet.instance()
		b.global_position = $Muzzule.global_position
		b.global_rotation = global_rotation
		var angle = get_global_transform().get_rotation()
		var bulle_speed = 1000
		b.set_linear_velocity(Vector2.RIGHT.rotated(angle) * bulle_speed)
		get_parent().call_deferred("add_child", b) # some how need
		#get_parent().add_child(b)
		fire=false
		
	var move_vec = Vector2()
	if Input.is_action_pressed("ui_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("ui_down"):
		move_vec.y += 1
	if Input.is_action_pressed("ui_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("ui_right"):
		move_vec.x += 1
		
	move_vec = move_vec.normalized()
	var delta = state.get_step()
	var MOVE_SPEED = 20000
	if get_tree().current_scene.is_kinematic_move():
		var vec=move_vec * MOVE_SPEED * delta
		state.set_linear_velocity(vec)
	else:
		var vec=move_vec * delta
		if get_tree().current_scene.is_impulse_move():
			state.apply_central_impulse(vec * 1000)
		else:
			var addvec=move_vec * 2
			state.add_central_force(addvec)
			var maxspeed = 50
			# limitation for easy control
			if state.linear_velocity.x > maxspeed:
				state.linear_velocity.x = maxspeed
			elif state.linear_velocity.x <- maxspeed:
				state.linear_velocity.x =- maxspeed
			
			if state.linear_velocity.y > maxspeed:
				state.linear_velocity.y = maxspeed
			elif state.linear_velocity.y <- maxspeed:
				state.linear_velocity.y =- maxspeed
				
	lookAtMouse(delta) 
