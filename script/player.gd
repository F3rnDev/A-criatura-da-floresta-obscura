extends CharacterBody2D

var interact_van = false
var interact_arvore = false
var interact_pegadas = false

var final_investigation = true

var first_lara_talk = true

var van_talk = true

var dialog_happening = false

var wasdPath = preload("res://nodes/wasd.tscn")

var wasd = wasdPath.instantiate()

var intro_dialog = true

var chatbox_path = preload("res://nodes/chatbox.tscn")

var SPEED = 150.0

var isPlaying = false

var dirAngle = 270

var start = 0

var stamina = 75

var dirX = 0

var dirY = 0

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
	if Global.get_dialog_status():
		dirX = Input.get_axis("move_left", "move_right")
		dirY = Input.get_axis("move_down", "move_up")
	else:
		dirX = 0
		dirY = 0

	
	if velocity.x == 0 and velocity.y == 0:
		$AudioStreamPlayer2D.stop()
		isPlaying = false
		
	else:
		if isPlaying == false:
			$AudioStreamPlayer2D.play()
			isPlaying = true

	if dirX > 0 and dirY == 0:
		$AnimatedSprite2D.animation = "walk_side"
		get_node("AnimatedSprite2D").set_flip_h( false )
		dirAngle = 0
	
	elif dirX < 0 and dirY == 0:
		$AnimatedSprite2D.animation = "walk_side"
		get_node("AnimatedSprite2D").set_flip_h( true )
		dirAngle = 180
		
	elif dirX == 0 and dirY > 0: 
		$AnimatedSprite2D.animation = "walk_back"
		dirAngle = 270
	
	elif dirX == 0 and dirY < 0: 
		$AnimatedSprite2D.animation = "walk_front"
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
		SPEED = 350
		stamina -= 1
	else:
		SPEED = 150 
		if stamina < 75 and not Input.is_action_pressed("run"):
			stamina += 1		
	
	#Dialogos
	if get_last_slide_collision() != null:
		if get_last_slide_collision().get_collider().is_in_group("parceira") and Input.is_action_just_pressed("interact") and Global.get_dialog_status():
			Global.set_dialog_status(false)
			if first_lara_talk == true:
				Global.set_num(0)
			elif !final_investigation:
				Global.set_num(7)
			else:
				Global.set_num(8)
			var chatbox = chatbox_path.instantiate()
			
			chatbox.get_child(0).get_child(0).position.y -= 370
			
			owner.add_child(chatbox)
			first_lara_talk = false
			intro_dialog = false
		if van_talk == false:
			if get_last_slide_collision().get_collider().is_in_group("van") and Input.is_action_just_pressed("interact") and Global.get_dialog_status():
				Global.set_dialog_status(false)
				Global.set_num(3)
				var chatbox = chatbox_path.instantiate()
				owner.add_child(chatbox)
				interact_van = true
				
			if get_last_slide_collision().get_collider().is_in_group("broken_tree") and Input.is_action_just_pressed("interact") and Global.get_dialog_status():
				Global.set_dialog_status(false)
				Global.set_num(4)
				var chatbox = chatbox_path.instantiate()
				owner.add_child(chatbox)
				interact_arvore = true
				
			if get_last_slide_collision().get_collider().is_in_group("pegadas") and Input.is_action_just_pressed("interact") and Global.get_dialog_status():
				Global.set_dialog_status(false)
				Global.set_num(5)
				var chatbox = chatbox_path.instantiate()
				owner.add_child(chatbox)
				interact_pegadas = true
				
	if position.y < 1900 and intro_dialog and Global.get_dialog_status() and dirY > 0:
			Global.set_dialog_status(false)
			Global.set_num(1)
			var chatbox = chatbox_path.instantiate()
			chatbox.get_child(0).get_child(0).position.y -= 370
			owner.add_child(chatbox)
			
	if position.y < 400 and van_talk:
		if first_lara_talk == false:
			Global.set_dialog_status(false)
			van_talk = false
			Global.set_num(2)
			var chatbox = chatbox_path.instantiate()
			owner.add_child(chatbox)
	
	if interact_arvore and interact_pegadas and interact_van and final_investigation and Global.get_dialog_status() == true:
		Global.set_dialog_status(false)
		final_investigation = false
		Global.set_num(6)
		var chatbox = chatbox_path.instantiate()
		owner.add_child(chatbox)

	if start == 0:
		self.add_child(wasd)
		wasd.position.y -= 100
		wasd.animation = "walk"
		
	if start == 150:
		wasd.animation = "e"
		
	if start == 300:
		wasd.animation = "sprint"
		
	if start < 450:
		start += 1
		
	if start == 450:
		remove_child(wasd)
		
	
	
	move_and_slide()
	$AnimatedSprite2D.play()
	queue_redraw()
