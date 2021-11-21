extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StartButton_pressed():
	get_node("buttons/StartButton/Oh-yeah").play()
	pass # Replace with function body.


func _on_Ohyeah_finished():
	get_tree().change_scene("res://Scenes/Mapa1.tscn")
	pass # Replace with function body.


func _on_OptionsButton_pressed():
	$OptionsPanel.visible = true
	pass # Replace with function body.
