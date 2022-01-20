extends KinematicBody


export (NodePath) var navigation_node
export (NodePath) var target_node

export (float) var gravity = 9.8
export (float) var mass = 10

onready var navigation: Navigation = get_node(navigation_node)
onready var target: Spatial = get_node(target_node)

onready var navigation_agent = $NavigationAgent

var velocity: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	if navigation_node != null:
		navigation_agent.set_navigation(navigation)
	else:
		print("navigation node hasn't been set")
		
	$Blackboard.set_data("Target", target_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var direction: Vector3 = (navigation_agent.get_next_location() - self.global_transform.origin).normalized()
	if !is_on_floor():
		velocity.y += -gravity * mass * delta
	else:
		velocity.y = 0
	move_and_slide(velocity -get_floor_normal(), Vector3.UP)
	$ybot.rotation.y = lerp_angle($ybot.rotation.y, atan2(direction.x, direction.z), delta * 7)

func _on_NavigationAgent_velocity_computed(safe_velocity):
	velocity.x = safe_velocity.x 
	velocity.z = safe_velocity.z 



