extends CharacterBody2D

var chatbox_path = preload("res://nodes/chatbox.tscn")

var SPEED = 300.0

var isPlaying = false

var dirAngle = 270

var stamina = 75

func deg2rad(deg):
	return deg *  PI/180

func _ready():
	add_to_group("player")
	
func _draw():
	if stamina < 75:
		draw_line(Vector2(-31.25, -64), Vector2(-31.25 + (stamina/1.2), -64), Color.DARK_GREEN, 6.0)
	
func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dirX = Input.get_axis("move_left", "move_right")
	var dirY = Input.get_axis("move_down", "move_up")

	
	if velocity.x == 0 and velocity.y == 0:
		$AudioStreamPlayer2D.stop()
		isPlaying = false
		
	else:
		if isPlaying == false:
			$AudioStreamPlayer2D.play()
			isPlaying = true

	
	if dirX > 0 and dirY == 0:
		$AnimatedSprite2D.animation = "idle_side"
		get_node("AnimatedSprite2D").set_flip_h( false )
		dirAngle = 0
	
	elif dirX < 0 and dirY == 0:
		$AnimatedSprite2D.animation = "idle_side"
		get_node("AnimatedSprite2D").set_flip_h( true )
		dirAngle = 180
		
	elif dirX == 0 and dirY > 0: 
		$AnimatedSprite2D.animation = "idle_back"
		dirAngle = 270
	
	elif dirX == 0 and dirY < 0: 
		$AnimatedSprite2D.animation = "idle_front"
		dirAngle = 90
	
	if dirX:
		velocity.x = dirX * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if dirY:
		velocity.y = dirY * -SPEED
	
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)


	if velocity.x == 0 and velocity.y == 0:
		if dirAngle == 90:
			$AnimatedSprite2D.animation = "idle_front"
			
		if dirAngle == 270:
			$AnimatedSprite2D.animation = "idle_back"
			
		if dirAngle == 0:
			$AnimatedSprite2D.animation = "idle_side"
			get_node("AnimatedSprite2D").set_flip_h( false )
		
		if dirAngle == 180:
			$AnimatedSprite2D.animation = "idle_side"
			get_node("AnimatedSprite2D").set_flip_h( true )
	
	if Input.is_action_pressed("run") and stamina > 0:
		SPEED = 500
		stamina -= 1
	else:
		SPEED = 300 
		if stamina < 75 and not Input.is_action_pressed("run"):
			stamina += 1		
			
	if get_last_slide_collision() != null:
		print(get_last_slide_collision().get_collider().is_in_group("parceira"))
		if get_last_slide_collision().get_collider().is_in_group("parceira") and Input.is_action_just_pressed("interact"):
			var chatbox = chatbox_path.instantiate()
			owner.add_child(chatbox)
	
	move_and_slide()
	$AnimatedSprite2D.play()
	queue_redraw()
		
	print(velocity)
	print(stamina)
