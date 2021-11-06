extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(0, 3)
	get_node("BattleThemes").get_children()[my_random_number].play()
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			togglePause()

func togglePause():
	get_node("ButtonsPause").visible = !get_node("ButtonsPause").visible
	get_tree().paused = !get_tree().paused
	pass


func _on_ContinueButton_pressed():
	togglePause()
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().change_scene("res://UI/MainMenu.tscn")
	pass # Replace with function body.
