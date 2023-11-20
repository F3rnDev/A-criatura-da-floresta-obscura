extends CharacterBody2D

var bullet_path = preload("res://nodes/tiro.tscn")

var SPEED = 300.0

var canShoot = 100

func deg2rad(deg):
	return deg *  PI/180

func shoot(angle):
	if canShoot == 100:
		
		var bullet = bullet_path.instantiate()
		owner.add_child(bullet)
		bullet.position.x = position.x
		bullet.position.y = position.y
		bullet.rotation = deg2rad(angle)
		canShoot = 0
	

func _ready():
	add_to_group("player")
	
func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dirX = Input.get_axis("move_left", "move_right")
	var dirY = Input.get_axis("move_down", "move_up")
	var dirAngle = 0
	
	
	if dirX > 0 and dirY == 0:
		$AnimatedSprite2D.animation = "right"
		dirAngle = 0
	elif dirX < 0 and dirY == 0:
		$AnimatedSprite2D.animation = "left"
		dirAngle = 180
	elif dirX == 0 and dirY > 0: 
		$AnimatedSprite2D.animation = "up"
		dirAngle = 270
	elif dirX == 0 and dirY < 0: 
		$AnimatedSprite2D.animation = "down"
		dirAngle = 90
	
	if dirX:
		velocity.x = dirX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if dirY:
		velocity.y = dirY * -SPEED
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_pressed("run"):
		SPEED = 600
	else:
		SPEED = 300 
	if Input.is_action_just_pressed("shoot"):
		shoot(dirAngle)
	
	if canShoot < 100:
		canShoot += 1
	$AnimatedSprite2D.stop()

