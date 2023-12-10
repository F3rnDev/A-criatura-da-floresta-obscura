extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Transition.transitionToScene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.get_end() == true:
		$Transition.transitionToBlack()

func _on_transition_transitioned():
	if Global.get_end() == true:
		get_tree().change_scene_to_file("res://nodes/cutscene2.tscn")
