extends Node2D

var canMove = [true, true]
# Called when the node enters the scene tree for the first time.
func getDistance(pos):
	var dis = position.distance_to(pos)
	var disX = pos.x - position.x


	var disY = pos.y - position.y
	
	var disArray = [dis, disX, disY]
	
	return disArray

func _ready():
	position.x = 640
	position.y = 360


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var posPlayer = get_tree().get_nodes_in_group("player")[0].position
	var player = getDistance(posPlayer)
	print(player)
	
	canMove = [true, true]
	
	for i in get_tree().get_nodes_in_group("limiters"):
		var limiter = getDistance(i.position)
		if sign(player[1]) == 1:
			if limiter[1] <= 640 and limiter[1] > 0:
				canMove[0] = false
		
		if sign(player[1]) == -1:
			if limiter[1] >= -640 and limiter[1] < 0:
				canMove[0] = false
				
		if sign(player[2]) == 1:
			if limiter[2] <= -360 and limiter[2] < 0:
				canMove[1] = false
			
		if sign(player[2]) == -1:
			if limiter[2] >= 360 and limiter[2] > 0:
				canMove[1] = false
			
		print(limiter)
	
	if (player[1] > 370 or player[1] < -370) and canMove[0] == true:
		position.x += sign(player[1]) * 5
			

	print(canMove)
