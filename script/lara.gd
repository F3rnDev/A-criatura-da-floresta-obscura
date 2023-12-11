extends StaticBody2D

var start = true

var move = true

var speed = 100

var velocity = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func getDistance(pos):
	var dis = position.distance_to(pos)
	var disX = pos.x - position.x


	var disY = pos.y - position.y
	
	var disArray = [dis, disX, disY]
	
	return disArray

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 2300
	position.x = 640
	$AnimatedSprite2D.animation = "idle_back"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(0, 0)
	if start and Global.get_lara_pos() == 0:
		if position.y > 2000:
			velocity = Vector2(0, -speed)
		elif position.x < 640:
			velocity = Vector2(speed, 0)
		else:
			start = false
	if move and Global.get_lara_pos() == 1:
		if position.y > 400:
			velocity = Vector2(0, -speed)
		elif position.x < 850:
			velocity = Vector2(speed, 0)
		else:
			move = false
			
	if velocity.x != 0 or velocity.y != 0:
		playFootsteps()
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_back"
			
		
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_front"
		
		elif velocity.x > 0:
			$AnimatedSprite2D.animation = "walk_side"
			get_node("AnimatedSprite2D").set_flip_h( false )
		
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "walk_side"
			get_node("AnimatedSprite2D").set_flip_h( true )
	
	else:
		$AudioStreamPlayer2D.stop()
		var posPlayer = get_tree().get_nodes_in_group("player")[0].position
		var player = getDistance(posPlayer)
	
		if player[2] < -100 or player[2] > 100:
			if player[2] < 100: 
				$AnimatedSprite2D.animation = "idle_back"
			elif player[2] >100:
				$AnimatedSprite2D.animation = "idle_front"	
		else:
			if player[1] > 0: 
				$AnimatedSprite2D.animation = "idle_side"
				get_node("AnimatedSprite2D").set_flip_h( false )
			elif player[1] < 0:
				$AnimatedSprite2D.animation = "idle_side"
				get_node("AnimatedSprite2D").set_flip_h( true )
		
	$AnimatedSprite2D.play()
	move_and_collide(velocity * delta)
	
func playFootsteps():
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()


