extends TextureButton # Или Control, если корневой узел Control

func _ready():
	pass

# Эту функцию нужно подключить к кнопке "Крестик"
func _on_close_button_pressed():
	# 1. Сообщаем главному меню, что мы закрываемся
	# (чтобы оно знало, что можно открывать настройки снова)
	if get_parent().get("settings_instance"): 
		get_parent().settings_instance = null
	# Или просто, если ты уверена в родителе:
	# get_parent().settings_instance = null
	
	# 2. Удаляем окно настроек
	queue_free()
