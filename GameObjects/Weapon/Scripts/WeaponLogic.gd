extends Spatial


export (AudioStream) var fire_sfx
export (float) var fire_rate = 0.25

onready var fire_delay: Timer = $FireDelay
onready var gun_sfx: AudioStreamPlayer = $GunSfx




# Called when the node enters the scene tree for the first time.
func _ready():
	fire_delay.wait_time = fire_rate
	fire_delay.one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _fire():
	if fire_delay.time_left <= 0.0:
		fire_delay.start()
		gun_sfx.stream = fire_sfx
		gun_sfx.play()



	
