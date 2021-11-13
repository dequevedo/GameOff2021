extends PathFollow
var vida = 10
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
		queue_free()
		#$BugDeathSound.play()

func hit(dano):
	vida = vida - dano

	
	pass # Replace with function body.

func _on_BugDeathSound_finished():
	queue_free()
	pass # Replace with function body.


func _on_Area_body_entered(body):
	if body.is_in_group("BULET"):
		if body.targuet == get_node("."):
			hit(body.dano)
			body.queue_free()
	pass # Replace with function body.
