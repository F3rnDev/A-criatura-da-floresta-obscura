extends Area2D

var speed = 750


func _physics_process(delta):
	position += transform.x * speed * delta

func on_Area2D_area_entered(area):
	print(area.name)
