extends CharacterBody2D


const SPEED = 300.0



func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dirX = Input.get_axis("move_left", "move_right")
	var dirY = Input.get_axis("move_down", "move_up")
	
	if dirX:
		velocity.x = dirX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if dirY:
		velocity.y = dirY * -SPEED
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
