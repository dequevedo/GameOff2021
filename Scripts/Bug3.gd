extends PathFollow
var vida = 30
var pos = 0.0
var vel = 0.03


func _ready():
	pass
func _process(delta):
	pos = unit_offset
	set_unit_offset(pos+vel*delta)

	if(pos >= 0.99):
		queue_free()
	
	
	if(vida <=0):
		queue_free()
