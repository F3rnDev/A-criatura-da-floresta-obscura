extends CanvasLayer

signal transitioned(endScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transitionToBlack():
	$ColorRect.color.a = 0.0;
	$AnimationPlayer.play("fade to black")

func transitionToScene():
	$ColorRect.color.a = 0.0;
	$AnimationPlayer.play("fade to normal")
	
func transitionToAnimation():
	$ColorRect.color.a = 0.0;
	$AnimatedSprite2D.modulate.a = 0.0
	$AnimationPlayer.play("fade to animation")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade to black":
		emit_signal("transitioned", true)
	else:
		emit_signal("transitioned")
