extends Spatial

var pre_bug_1 = preload("res://Scenes/Bugs/Bug1.tscn")
var pre_bug_2 = preload("res://Scenes/Bugs/Bug2.tscn")

var bugSpawList = Array()
var rodadaCont = 0

var rodadas = [[1,1,1,1,1,1,1,1,1,1],
				[1,1,1,2,2,2,2,1,1,1],
				[1,1,1,2,2,2,3,1,2,1]]
				
func _ready():
	rodada()
	pass



func rodada():
	for i in rodadas[rodadaCont]:
		var new_bug 
		
		match i:
			1: new_bug = pre_bug_1.instance()
			2: new_bug = pre_bug_2.instance()
		
		bugSpawList.append(new_bug)
	$SpawnTime.start()
	
	if rodadaCont < rodadas.size()-1:
		rodadaCont +=1 
		$Rodada.start()
	else :
		print('end')
		$Rodada.stop()
	

func _on_Rodada_timeout():
	rodada()
	pass


func _on_SpawnTime_timeout():
	$Caminho.add_child(bugSpawList[0])
	bugSpawList.remove(0)
	if(bugSpawList.size()>0):
		$SpawnTime.start()
	pass
