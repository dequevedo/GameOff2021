extends Spatial

var bulet = preload("res://Scenes/Armas/Bulet.tscn")

var in_muve = false
var in_area_permitida = false
var targuet_position = Vector3(0,0,0)

func _ready():
	pass
func _process(delta):
	var caminhoChild = get_parent().get_child(0).get_child(0)
	if caminhoChild:
		$Spatial/Formiga_01/Armature.look_at(caminhoChild.translation * Vector3(1,0,1),Vector3(0,1,0))
	pass


func _on_Shot_timeout():
	var caminhoChild = get_parent().get_child(0).get_child(0)
	if caminhoChild:
		var bulet_ = bulet.instance()
		get_parent().add_child(bulet_)
		bulet_.global_transform.origin = $Bulet_position.global_transform.origin
		bulet_.targuet = caminhoChild

		
		
		
		pass
	pass 
