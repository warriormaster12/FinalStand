extends KinematicBody

export (float) var jog_speed = 5.0
export (float) var sprint_speed = 10.0
export (float) var accel = 8.0
export (float) var angular_accel = 7.0
export (float) var gravity = 9.8
export (float) var mass = 10



var direction: Vector3
var strafe_dir: Vector3
var velocity: Vector3

var speed: float

var aiming: bool = false
var shooting:bool = false
var sprinting:bool = false

var mouse_dir: Vector3


func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	var h_rot = $CameraManager/Camera_h.global_transform.basis.get_euler().y
	direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"), 
	0,
	Input.get_action_strength("forward") - Input.get_action_strength("backward"))
	
	if Input.is_action_pressed("aiming"):
		$PlayerMesh/Skeleton/GripIk.stop()
		$PlayerMesh/Skeleton.clear_bones_global_pose_override()
		$PlayerMesh/Skeleton/SkeletonIk.start()
		aiming = true
	else:
		$PlayerMesh/Skeleton/SkeletonIk.stop()
		$PlayerMesh/Skeleton.clear_bones_global_pose_override()
		$PlayerMesh/Skeleton/GripIk.start()
		aiming = false
		
	if Input.is_action_pressed("shoot"):
		if aiming and !sprinting:
			shooting = true
			$PlayerMesh/Skeleton/BoneAttachment/Rifle._fire()
	else:
		shooting = false
		
	
	strafe_dir = direction
	direction = direction.rotated(Vector3.UP, h_rot).normalized()
	
	if Input.is_action_pressed("sprint") and !aiming:
		sprinting = true
		if strafe_dir.z > 0:
			speed = sprint_speed
		else: 
			speed = jog_speed
	else:
		sprinting = false
		speed = jog_speed
	
	
	velocity = lerp(velocity, direction * speed, delta * accel)
	
	
	
	move_and_slide(velocity -get_floor_normal(), Vector3.UP)
	
	if !is_on_floor():
		velocity.y += -gravity * mass * delta
	else:
		velocity.y = 0
	
	$PlayerMesh.rotation.y = lerp_angle($PlayerMesh.rotation.y, h_rot, delta * angular_accel)
	
