extends Node2D


func move_camera():
	position.x += 10
	
func _ready():
	position.x = 572
	position.y = 333

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
