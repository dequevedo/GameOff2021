extends Spatial

var bulet = preload("res://Scenes/Armas/Bulet.tscn")
onready var camera = get_parent().get_node("Camera")
var in_muve = false
var in_area_permitida = false
var targuet_position = Vector3(0,0,0)
var rayOrigin = Vector3()
var rayEnd = Vector3()
var in_allowed_area = true


func _ready():
	
	pass
	
func _physics_process(delta):
	if in_muve :
		var space_state = get_world().direct_space_state
	
		var mouse_position = get_viewport().get_mouse_position()
		
		rayOrigin = camera.project_ray_origin(mouse_position)
		
		rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) *2000
		
		var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
		
		if not intersection.empty() and intersection.collider.is_in_group('ALLOWED_AREA'):
			
			
			translation = intersection.position
			

func _input(event):
	if event.is_action_pressed("click") and in_allowed_area and in_muve:
				in_muve = false
				print(in_muve)
	


func _process(delta):
	
	
	if get_parent().get_child(0).get_children().size() > 0 and not in_muve:
		var caminhoChild = get_parent().get_child(0).get_child(0)
		$Spatial/Formiga_01/Armature.look_at(caminhoChild.translation * Vector3(1,0,1),Vector3(0,1,0))
	pass


func _on_Shot_timeout():
	if get_parent().get_child(0).get_children().size() > 0 and not in_muve :
		var caminhoChild = get_parent().get_child(0).get_child(0)
		var bulet_ = bulet.instance()
		get_parent().add_child(bulet_)
		bulet_.global_transform.origin = $Bulet_position.global_transform.origin
		bulet_.targuet = caminhoChild
		pass
	pass 
