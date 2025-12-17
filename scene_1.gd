extends Node2D

func _ready():
	# (Тут у тебя код про музыку, оставь его)
	# ...
	
	# 1. Ждем 3 секунды
	await get_tree().create_timer(3.0).timeout
	
	# 2. Список фраз для диалога
	var my_text = [
		"Consciousness returns not with a sudden flash, but as a viscous, slow ascent from the depths of a non-existent ocean, where eyelids part to sever the veil of non-being, and the world reveals itself in frozen grisaille, bereft of the breath of life.",
		"Темные стебли травы, подобные замерзшим струнам, едва касаются босых ступней — прикосновение, полное холодной, отстраненной нежности, пока ветер, лишенный направления, скользит по коже, не освежая, а будто слизывая остатки тепла и унося с собой осколки прошлого.",
		"LIAFGULGufLGUIlifyFYLAUyflwlFYLwuWlAFIWYiwfglaGUFIWF^A&@*7q8429w8q964q28????///////",
		"qwertyuiop[]asdfghjkl;'zxcvbnm,./"
	]
	
	# 3. Запускаем диалог!
	# (Убедись, что имя узла DialogueLayer правильное)
	$DialogueLayer.start_dialogue(my_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
