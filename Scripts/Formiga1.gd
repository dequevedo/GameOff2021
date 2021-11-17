extends Spatial

onready var camera = get_parent().get_parent().get_node("Camera")
var in_muve = false
var rayOrigin = Vector3()
var rayEnd = Vector3()
var in_allowed_area = false
var targuets = []
var range_radius = 1.3
var bulet_dano = 1





func _ready():
	set_range_radius(range_radius)
	pass
	
func _physics_process(delta):
	if in_muve :
		var space_state = get_world().direct_space_state
	
		var mouse_position = get_viewport().get_mouse_position()
		
		rayOrigin = camera.project_ray_origin(mouse_position)
		
		rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) *2000
		
		var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
		
		if not intersection.empty() and intersection.collider.is_in_group('ALLOWED_AREA'):
			
			global_transform.origin = intersection.position
			in_allowed_area = true
		elif intersection.empty() or not intersection.collider.is_in_group('ALLOWED_AREA'): 
			in_allowed_area = false
			
func _input(event):
	if event.is_action_pressed("click") and in_allowed_area and in_muve:
				in_muve = false
				$range/Showed_range.visible = false
	if event.is_action_pressed("right_click") and in_muve:
		queue_free()


func _process(delta):
	
	if in_muve:
		get_node("Body").get_child(0).disabled = true
	else:
		get_node("Body").get_child(0).disabled  = false
	
	
	if get_parent().get_parent().get_child(0).get_children().size() > 0 and not in_muve:
		var caminhoChild = get_parent().get_parent().get_child(0).get_child(0)
		$Spatial/Formiga_01/Armature.look_at(caminhoChild.global_transform.origin * Vector3(1,0,1),Vector3(0,1,0))
	pass


func _on_Shot_timeout():
	
	if targuets.size() > 0 and not in_muve :
		var targuet  = targuets[0]
		var bulet_ = load("res://Scenes/Armas/Bulet.tscn").instance()
		get_parent().get_parent().add_child(bulet_)
		bulet_.global_transform.origin = $Bulet_position.global_transform.origin
		bulet_.targuet = targuet
		bulet_.dano = bulet_dano
		pass
	pass 


func _on_range_area_entered(area):
	if area.get_parent().is_in_group("BUG"):
		targuets.append(area.get_parent())
	pass 


func _on_range_area_exited(area):
	if area.get_parent().is_in_group("BUG"):
		targuets.erase(area.get_parent())
	pass # Replace with function body.

func set_range_radius(radius):
	
	$range/CollisionShape.shape.set_radius(radius)
	$range/Showed_range.radius = radius
	range_radius = radius
	pass


func _on_Button1_button_down():
	set_range_radius(range_radius+0.2)
	pass


func _on_Button2_button_down():
	bulet_dano+=1
	pass 
