extends ColorRect

var dialog_path = 0
var text_speed = 0.05

var dialog_index = 0

var dialog_cluster = [
	[
		{"name":"Pessoa 1", "text":"Olá."},
		{"name":"Pessoa 2", "text":"Olá."},
		{"name":"Pessoa 1", "text":"Como vai."},
		{"name":"Pessoa 2", "text":"Vou bem."},
	],
	[
		{"name":"Pessoa 2", "text":"Olá."},
		{"name":"Pessoa 1", "text":"Olá."},
		{"name":"Pessoa 2", "text":"Como vai?"},
		{"name":"Pessoa 1", "text":"Vou bem!"},
	]
]

var dialog = dialog_cluster[dialog_index]

var phrase_num = 0
var finished = false
	
func next_phrase():
	if phrase_num >= len(dialog):
		queue_free()
		return
	
	finished = false
	
	$name.bbcode_text = dialog[phrase_num]["name"]
	$text.bbcode_text = dialog[phrase_num]["text"]
	
	$text.visible_characters = 0
	
	while $text.visible_characters < len($text.text):
		$text.visible_characters += 1
		$AudioStreamPlayer2D.play()
		$Timer.start()
		await($Timer.timeout) 
		
	finished = true
	phrase_num += 1
	return
		
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = text_speed
	next_phrase()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("confirm"):
		if finished:
			next_phrase()
		else:
			$text.visible_characters = len($text.text)
	
