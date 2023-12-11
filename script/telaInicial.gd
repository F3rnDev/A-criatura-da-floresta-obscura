extends Control

func _input(event):
	if event is InputEventKey and event.pressed:
		if Input.is_action_just_pressed("Exit"):
			get_tree().quit()
		else:
			startGame()
	
func startGame():
	$Label.visible = false
	$Transition.transitionToAnimation()


func _on_ready():
	$AnimatedSprite2D.play("default")


func _on_transition_transitioned():
	get_tree().change_scene_to_file("res://nodes/cutscene.tscn")
