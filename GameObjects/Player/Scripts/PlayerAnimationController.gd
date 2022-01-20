extends AnimationTree



onready var player = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set("parameters/MovementInCombat/blend_position", Vector2(-player.strafe_dir.x, player.strafe_dir.z) * player.velocity.length())
	if player.aiming:
		set("parameters/Aim/blend_amount", 1.0)
	else:
		set("parameters/Aim/blend_amount", 0.0)
	
	set("parameters/Fire/active", player.shooting)
	
