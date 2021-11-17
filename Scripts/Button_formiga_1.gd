extends Button


var custo = 10



func _ready():
	pass
func _process(delta):
	if Global.moedas<custo:
		disabled = true
	else:
		disabled = false
