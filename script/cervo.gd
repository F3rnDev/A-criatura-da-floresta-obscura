extends CharacterBody2D


const SPEED = 300.0
var dir = 1
var timer = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.

func stop():
	timer = 0
	
func _ready():
	add_to_group("enemy")
	
func _physics_process(delta):
	velocity.x = SPEED * dir
	if timer == 50:
		if move_and_collide(velocity * delta):
			dir = dir * -1
		
	if timer < 50:
		timer += 1
		
