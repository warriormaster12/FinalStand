extends Spatial

export (float) var cam_rot_min = -90
export (float) var cam_rot_max = 90
export (float) var mouse_sens = 0.3

export (float) var vert_accel = 10
export (float) var horz_accel = 10

export (float) var aim_speed = 10

onready var camera_h: Spatial = $Camera_h
onready var camera_v: Spatial = $Camera_h/Camera_v
onready var camera_boom: Spatial = $Camera_h/Camera_v/CameraBoom
onready var camera: Camera = $Camera_h/Camera_v/CameraBoom/Camera

onready var player = get_parent()

var camera_rot_h: float 
var camera_rot_v: float


# Called when the node enters the scene tree for the first time.
func _ready():
	camera.add_exception(get_parent())
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		camera_rot_h += -event.relative.x * mouse_sens
		camera_rot_v += -event.relative.y * mouse_sens

func _process(delta):
	
	if player.aiming:
		camera.fov = lerp(camera.fov, 45, aim_speed * delta)
		camera_boom.translation.x = lerp(camera_boom.translation.x, -0.9, aim_speed * delta)
		
	else:
		camera.fov = lerp(camera.fov, 70,  aim_speed * delta)
		camera_boom.translation.x = lerp(camera_boom.translation.x, -0.3, aim_speed * delta)
	camera_h.rotation_degrees.y = lerp(camera_h.rotation_degrees.y, camera_rot_h, delta * vert_accel)
	camera_v.rotation_degrees.x = lerp(camera_v.rotation_degrees.x, camera_rot_v, delta * horz_accel)
	camera_v.rotation_degrees.x = clamp(camera_v.rotation_degrees.x, cam_rot_min, cam_rot_max)
