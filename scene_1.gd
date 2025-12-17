extends Node2D

func _ready():
	# (Тут у тебя код про музыку, оставь его)
	# ...
	
	# 1. Ждем 3 секунды
	await get_tree().create_timer(3.0).timeout
	
	# 2. Список фраз для диалога
	var my_text = [
		"Test Text......",
		"TEST TEXT TEST TEXT TEST TEXT",
		"LIAFGULGufLGUIlifyFYLAUyflwlFYLwuWlAFIWYiwfglaGUFIWF^A&@*7q8429w8q964q28????///////",
		"qwertyuiop[]asdfghjkl;'zxcvbnm,./"
	]
	
	# 3. Запускаем диалог!
	# (Убедись, что имя узла DialogueLayer правильное)
	$DialogueLayer.start_dialogue(my_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
