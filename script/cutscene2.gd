extends VideoStreamPlayer

func _on_finished():
	Global.end = false
	Global.lara_pos = 0
	get_tree().change_scene_to_file("res://nodes/tela_inicial.tscn")


func _on_ready():
	$Transition.transitionToScene()
	play()
