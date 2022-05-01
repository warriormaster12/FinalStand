extends BTLeaf

export(float) var allowed_radius = 20.0

var target_reached: bool = false

var timer: float = 0.0


# (Optional) Do something BEFORE tick result is returned.
func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	pass
	

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var next_location:Vector3 = agent.navigation_agent.get_next_location()
	var current_pos:Vector3 = agent.global_transform.origin
	var vel: Vector3 = (next_location - current_pos).normalized()  * agent.navigation_agent.max_speed
	agent.navigation_agent.set_velocity(vel) 
	return succeed()
	


