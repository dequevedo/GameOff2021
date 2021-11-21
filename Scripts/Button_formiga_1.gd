extends TextureButton


var custo = 10



func _ready():
	pass
func _process(delta):
	if Global.moedas<custo:
		disabled = true
	else:
		disabled = false


func _on_Button_formiga_1_pressed():
	$click.play()
	pass # Replace with function body.


func _on_Button_formiga_1_mouse_entered():
	$hover.play()
	pass # Replace with function body.
