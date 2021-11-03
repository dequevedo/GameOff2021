extends Spatial

var bulet = preload("res://Scenes/Armas/Bulet.tscn")

var in_muve = false
var in_area_permitida = false

func _ready():
	pass
func _process(delta):
	pass


func _on_Shot_timeout():
	var bulet_ = bulet.instance()
	bulet_.global_transform.origin = $Bulet_position.global_transform.origin
	bulet_.targuet = get_parent().get_child(0).get_child(0)

	get_parent().add_child(bulet_)
	#$Spatial/Formiga_01.set_radius($Spatial/Formiga_01.rotation_degrees.angle_to(bulet_.targuet.translation)+45)
		
	
	pass 
