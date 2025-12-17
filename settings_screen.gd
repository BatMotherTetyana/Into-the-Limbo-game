extends Node2D 

func _ready():
	pass

func _on_texture_button_pressed():
	# Проверяем, находимся ли мы внутри Паузы
	if get_parent().name == "PauseLayer":
		# ВАРИАНТ 1: МЫ В ПАУЗЕ
		
		# 1. Скрываем само окно настроек (себя)
		self.visible = false
		
		# 2. Находим у "родителя" (в сцене PauseLayer) окно меню и включаем его
		# Убедись, что в сцене PauseLayer узел называется именно PauseWindow!
		get_parent().get_node("PauseWindow").visible = true
		
	else:
		# ВАРИАНТ 2: МЫ В ГЛАВНОМ МЕНЮ
		
		# Очищаем переменную в меню (чтобы не было ошибок при повторном открытии)
		if "settings_instance" in get_parent():
			get_parent().settings_instance = null
			
		# Удаляем окно полностью
		queue_free()


func _on_h_slider_2_value_changed(value):
	# 1. Находим канал "Music" (Музыка)
	var bus_index = AudioServer.get_bus_index("Music")
	
	# 2. Меняем громкость
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	# 3. Сохраняем настройки
	Global.music_volume = value
	Global.save_settings()


func _on_h_slider_value_changed(value):
	# Тут пишем "Sounds", потому что это нижний ползунок
	var bus_index = AudioServer.get_bus_index("Sounds") 
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	Global.sound_volume = value # И сохраняем как звук
	Global.save_settings()
