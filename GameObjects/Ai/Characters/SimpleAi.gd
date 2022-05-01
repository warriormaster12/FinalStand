extends KinematicBody

export (NodePath) var navigation_node
export (NodePath) var target_node

onready var navigation: Navigation = get_node(navigation_node)
onready var target: Spatial = get_node(target_node)

onready var navigation_agent: NavigationAgent = $NavigationAgent

var velocity: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent.set_navigation(navigation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if !is_on_floor():
		velocity.y += -9.81 * delta
	else: 
		velocity.y = 0
	
	var next_location:Vector3 = navigation_agent.get_next_location()
	var current_pos:Vector3 = global_transform.origin
	var vel: Vector3 = (next_location - current_pos).normalized()  * navigation_agent.max_speed
	navigation_agent.set_velocity(vel)
	
	
	move_and_slide(velocity, Vector3.UP)


func _on_NavigationAgent_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_Timer_timeout():
	navigation_agent.set_target_location(target.global_transform.origin)
