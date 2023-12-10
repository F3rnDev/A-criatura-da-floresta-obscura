extends CanvasLayer

signal transitioned

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transitionToBlack():
	$ColorRect.color.a = 0.0;
	$AnimationPlayer.play("fade to black")

func transitionToScene():
	$ColorRect.color.a = 0.0;
	$AnimationPlayer.play("fade to normal")


func _on_animation_player_animation_finished(anim_name):
	emit_signal("transitioned")
