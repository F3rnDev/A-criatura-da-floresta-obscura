extends Node2D
# Called when the node enters the scene tree for the first time.
func getDistance(pos):
	var dis = position.distance_to(pos)
	var disX = pos.x - position.x


	var disY = pos.y - position.y
	
	var disArray = [dis, disX, disY]
	
	return disArray

func _ready():
	position.x = 572
	position.y = 333


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var posPlayer = get_tree().get_nodes_in_group("player")[0].position
	var player = getDistance(posPlayer)
	print(player)
	
	if player[1] > 370 or player[1] < -370:
		position.x += sign(player[1]) * 5
