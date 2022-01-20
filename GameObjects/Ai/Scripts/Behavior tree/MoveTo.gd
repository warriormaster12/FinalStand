extends BTLeaf

export(float) var allowed_radius = 20.0

var target_reached: bool = false

var agent_ref: Spatial

# (Optional) Do something BEFORE tick result is returned.
func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	agent_ref = agent
	agent.navigation_agent.target_desired_distance = allowed_radius
	#if agent_ref.navigation_agent:
	agent_ref.navigation_agent.set_target_location(agent_ref.target.global_transform.origin)
	
	
	


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if !agent.navigation_agent.is_target_reached():
		var next_location = agent.navigation_agent.get_next_location()
		var vel = agent.global_transform.origin.direction_to(next_location) * agent.navigation_agent.max_speed
		agent.navigation_agent.set_velocity(vel) 
		return fail()
	else:
		return succeed()







