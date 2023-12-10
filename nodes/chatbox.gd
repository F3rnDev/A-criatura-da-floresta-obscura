extends AnimatedSprite2D

var dialog_path = 0
var text_speed = 0.05

var dialog_index = Global.get_dialog_number()

var dialog_cluster = [
	[
		{"name":"Lara Vicenza", "text":"Você tem certeza de que vai deixar sua arma no carro?"},
		{"name":"Marcos Valentino", "text":"Relaxa pô, tu mesmo já disse que o assassino não retornaria na cena do crime"},
		{"name":"Lara Vicenza", "text":"Independentemente, qualquer coisa pode acontecer. É melhor prevenir do que remediar"},
		{"name":"Marcos Valentino", "text":"Você se preocupa demais Lara! Relaxa um pouco"},
		{"name":"Lara Vicenza", "text": "Eu tô relaxada, só quero estar preparada se algo acontecer. Enfim, você sabe o que faz, só não diga que eu não te avisei"}
	],
	[
		{"name":"Lara Vicenza", "text": "Espera, vem aqui!"}
	],
	[
		{"name":"Marcos Valentino", "text": "Uuuuh okay, isso é estranho"},
		{"name":"Lara Vicenza", "text": "O corpo devia estar mais dentro da floresta, sem contar que foram reportados dois corpos"},
		{"name":"Marcos Valentino", "text": "A descrição não bate também, pelo visto realmente tem um maluco na floresta"},
		{"name":"Lara Vicenza", "text": "Nesse caso, 3 vítimas até agora"},
		{"name":"Marcos Valentino", "text": "Sim, Eu vou dar uma olhada em volta, tem alguma coisa muito estranha aqui"},
		{"name":"Lara Vicenza", "text": "Ok, toma cuidado Marcos"},
	],
	[
		{"name":"Marcos Valentino", "text": "A cabeça desse cara tá toda ferrada. É como se um carro tivesse passado por cima dele"},
		{"name":"Lara Vicenza", "text": "Homem, mais velho, provavelmente um alcóolatra considerando o cheiro"},
		{"name":"Marcos Valentino", "text": "Ia comentar isso, o cheiro do álcool é mais forte do que do cadáver. Pelo estado parece que foi recente"},
		{"name":"Marcos Valentino", "text": "..."},
		{"name":"Marcos Valentino", "text": "Espera! O trailer meio amassado próximo ao corpo. Ele foi arremessado, e com muita força"},
		{"name":"Lara Vicenza", "text": "Será que foi um ataque de algum animal silvestre?"},
		{"name":"Marcos Valentino", "text": "É uma possibilidade, vou continuar procurando"},
	],
	[
		{"name":"Marcos Valentino", "text": "Mas o que é isso!? o que poderia gerar esse estrago? Isso tá muito estranho"},
		{"name":"Marcos Valentino", "text": "Ok, várias árvores esmagadas. Levam para dentro da floresta. Seja lá o que isso for, com certeza não é humano"},
	],
	[
		{"name":"Marcos Valentino", "text": "Ei Lara! Olha essas pegadas!"},
		{"name":"Lara Vicenza", "text": "Essas pegadas são bem incomuns, não parece um rastro deixado por um ser humano, nem mesmo por um animal dessa floresta"},
		{"name":"Marcos Valentino", "text": "Parece “agressivo”, é como se um gorila desse vários socos no chão"},
		{"name":"Lara Vicenza", "text": "hahah, pode ter certeza de que gorilas não vivem nessa floresta"},
		{"name":"Marcos Valentino", "text": "Verdade, um elefante seria mais apropriado. Enfim, esse rastro parece ir a algum lugar, vou segui-lo"},
	],
	[
		{"name":"Marcos Valentino", "text": "Ok, já tenho uma boa ideia. Vou reportar de volta pra Lara"},
	],
	[
		{"name":"Marcos Valentino", "text": "Ok, Lara. Certamente seja lá o que fez isso, não é humano"},
		{"name":"Lara Vicenza", "text": "É extremamente peculiar. Tudo aponta para um ataque de algum animal silvestre. Mas o porte dele…"},
		{"name":"Marcos Valentino", "text": "Sim, ele teria que ser um brutamontes, pra não dizer o mínimo. Não me parece um animal que viveria nessa floresta"},
		{"name":"Lara Vicenza", "text": "Mas de onde ele poderia ter vindo? Não existem zoológicos próximos a essa floresta"},
		{"name":"Marcos Valentino", "text": "Um carregamento talvez, algum tipo de transferência para outro zoológico?"},
		{"name":"Lara Vicenza", "text": "É uma possibilidade. Bem, se for um animal, ele ainda deve estar dentro da floresta. Podíamos contatar o controle de animais e voltar aqui quando ele tiver sido contido"},
		{"name":"Marcos Valentino", "text": "Aí nós chegamos em um problema. O guarda florestal"},
		{"name":"Lara Vicenza", "text": "O que tem ele?"},
	]
]

var dialog = dialog_cluster[dialog_index]

var phrase_num = 0
var finished = false

func set_dialog_index(number):
	dialog_index = number
	return
	
func next_phrase():
	if phrase_num >= len(dialog):
		if dialog_index == 7:
			Global.set_end()

		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		t.timeout.connect(_on_timer_timeout)
		
		add_child(t)
		t.start()
		return
	
	finished = false
	
	$name.bbcode_text = "[center]" + dialog[phrase_num]["name"] + "[/center]"
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
		
# Called when the node enters	 the scene tree for the first time.
func _ready():
	$Timer.wait_time = text_speed
	next_phrase()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("confirm") or Input.is_action_just_pressed("interact"):
		if !Global.get_dialog_status():
			if finished:
				next_phrase()
			else:
				$text.visible_characters = len($text.text)

func _on_timer_timeout():
	print("timer timeout")
	Global.set_dialog_status(true)
	queue_free()
