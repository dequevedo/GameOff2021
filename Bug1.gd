extends PathFollow
var vida = 10
var pos = 0.0
var vel = 0.05


func _ready():
	pass
func _process(delta):
	pos = get_unit_offset()
	set_unit_offset(pos+vel*delta)
	if(pos == 1):
		print("fim do caminho")
	
	
	if(vida <=0):
		queue_free()
