extends Spatial


var targuet
var vel = 100
var dir = Vector3()
var dano = 1

func _ready():
	pass
	
func _process(delta):
	
	if !is_instance_valid(targuet):
		queue_free()
	else: 
		dir = (targuet.global_transform.origin - global_transform.origin)
		dir = dir.normalized()
		global_transform.origin = global_transform.origin  + vel * dir *delta
	
	pass


func _on_Area_area_entered(area):
	if(area.get_parent() == targuet):
		queue_free()
	pass # Replace with function body.
