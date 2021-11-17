extends Spatial

onready var camera = $Camera
var rayOrigin = Vector3()
var rayEnd = Vector3()
var mouse_world_position
var intersection
var upgrade_open = {}


var roundAudios = [
	preload(str("res://SFX/Round/1.ogg")),
	preload(str("res://SFX/Round/2.ogg")),
	preload(str("res://SFX/Round/3.ogg")),
	preload(str("res://SFX/Round/4.ogg")),
	preload(str("res://SFX/Round/5.ogg")),
	preload(str("res://SFX/Round/6.ogg")),
	preload(str("res://SFX/Round/7.ogg")),
	preload(str("res://SFX/Round/8.ogg")),
	preload(str("res://SFX/Round/9.ogg")),
	preload(str("res://SFX/Round/10.ogg")),
	preload(str("res://SFX/Round/final_round.ogg"))
]

var bugSpawnList = Array()
var rodadaCont = 0

var rodadas = [
	[1,1,1,2,2,2,1,1,1,3],
	[1,1,1,2,2,2,2,1,1,1],
	[1,1,1,2,3,2,3,1,2,1]
]

func _ready():
	rodada()
	pass

func _input(event):
	if   event.is_action_pressed("click"):
		
		if not intersection.empty() and intersection.collider.get_parent().is_in_group("FORMIGA"):
			close_lest_upgrade()
			open_upgrade(intersection.collider.get_parent().get_node("upgrades"))
		else :
			
			close_lest_upgrade()

 
	pass

func open_upgrade(upgrade):

	upgrade_open = upgrade
	upgrade_open.rect_position = get_viewport().get_mouse_position()
	upgrade_open.get_node('AnimationPlayer').play('aparecer')
	upgrade_open.get_parent().get_node('range/Showed_range').visible = true
	pass
func close_lest_upgrade():
	if upgrade_open:
		upgrade_open.get_node('AnimationPlayer').play('sumir')
		upgrade_open.get_parent().get_node('range/Showed_range').visible = false
		upgrade_open = {}

func _physics_process(delta):
	
	var space_state = get_world().direct_space_state
	
	var mouse_position = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mouse_position)
	
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) *2000
	
	intersection = space_state.intersect_ray(rayOrigin, rayEnd)
	
	if not intersection.empty():
		
		mouse_world_position = intersection.position
	
	pass

func rodada():
	if rodadaCont > rodadas.size()-1 :
		print('end')
		rodadaCont +=1 
		$Rodada.stop()
		missionCompleted()
		return
	
	if(rodadaCont == rodadas.size()-1):
		$Interface/Round_titulo.text = str("Final Round")
	else: 
		$Interface/Round_titulo.text = str("Round ", rodadaCont+1)
	
	$Interface/AnimationPlayer.play("sumir")
	playRoundAudio(rodadaCont+1)
		
	for i in rodadas[rodadaCont]:
		var new_bug 
		
		match i:
			1: new_bug = load("res://Scenes/Bugs/Bug1.tscn").instance()
			2: new_bug = load("res://Scenes/Bugs/Bug2.tscn").instance()
			3: new_bug = load("res://Scenes/Bugs/Bug3.tscn").instance()
		
		bugSpawnList.append(new_bug)
	$SpawnTime.start()
	
	if rodadaCont <= rodadas.size()-1:
		rodadaCont +=1 
		$Rodada.start()

func _on_Rodada_timeout():
	rodada()
	pass


func _on_SpawnTime_timeout():
	$Caminho.add_child(bugSpawnList[0])
	bugSpawnList.remove(0)
	if(bugSpawnList.size()>0):
		$SpawnTime.start()
	pass

func playRoundAudio(actualRound):
	if(actualRound == rodadas.size()):
		$Interface/RoundAudio.volume_db = -50
	else: 
		$Interface/RoundAudio.volume_db = 0
	$Interface/RoundAudio.play()
	pass

func _on_RoundAudio_finished():
	var RoundNumberAudio = $Interface/RoundNumberAudio
	RoundNumberAudio.stream = roundAudios[rodadaCont-1]
	RoundNumberAudio.play()
	pass
	
func missionCompleted():
	print('missioncompleted')
	$Interface/Round_titulo.text = str("Mission Completed! ")
	$Interface/Round_titulo.modulate = Color(1, 1, 1, 1)
	$Interface/MissionCompletedAudio.play()
	$Interface/FinishOverlay.visible = true
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://UI/MainMenu.tscn")
	pass # Replace with function body.


func _on_Button_formiga_1_pressed():

	if get_node("formigas").get_child_count()<=0 or not get_node("formigas").get_child(get_node("formigas").get_child_count()-1).in_muve:
		var pre_formiga_1 = load("res://Scenes/Armas/Formiga1.tscn")
		var new_formiga = pre_formiga_1.instance()
		new_formiga.in_muve = true
		get_node("formigas").add_child(new_formiga)
	pass
