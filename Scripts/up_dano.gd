extends Button

var custo = 150

func _ready():
	pass
func _process(delta):
	if Global.moedas<custo:
		disabled = true
	else:
		disabled = false
