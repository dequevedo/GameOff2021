extends PathFollow
var vida = 15
var pos = 0.0
var vel = 0.05


func _ready():
	pass
func _process(delta):
	pos = unit_offset
	set_unit_offset(pos+vel*delta)

	if(pos >= 0.99):
		queue_free()
	
	
	if(vida <=0 and !$BugDeathSound.playing):
		visible = false
		$BugDeathSound.play()

func hit(dano):
	vida = vida - dano

func _on_Area_area_entered(area):
	if area.is_in_group("BULET"):
		if area.targuet == get_node("."):
			hit(area.dano)
			area.queue_free()
	pass 


func _on_BugDeathSound_finished():
	queue_free()
	pass # Replace with function body.
