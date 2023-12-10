extends StaticBody2D

var start = true

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 670
	position.x = 650
	$AnimatedSprite2D.animation = "idle_back"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start:
		while position.y > 570:
			var t = Timer.new()
			position.y -= 2
			t.set_wait_time(0.4)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			await t.timeout
			t.queue_free()
		$AnimatedSprite2D.animation = "idle_side"
		get_node("AnimatedSprite2D").set_flip_h( false )
		while position.x < 700:
			var t = Timer.new()
			position.x += 2
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			await t.timeout
			t.queue_free()
		$AnimatedSprite2D.animation = "idle_side"
		get_node("AnimatedSprite2D").set_flip_h( true )
		start = false
	$AnimatedSprite2D.play()
