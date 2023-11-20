extends Area2D

var speed = 750


func _physics_process(delta):
	position += transform.x * speed * delta
	
	for bodie in get_overlapping_bodies():
		if not bodie.is_in_group("player"):
			if bodie.is_in_group("enemy"):
				bodie.stop()
			queue_free()
