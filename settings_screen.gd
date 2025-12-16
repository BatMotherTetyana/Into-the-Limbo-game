extends Node2D 

func _ready():
	pass

func _on_texture_button_pressed() -> void:
		# Сообщаем главному меню, что переменная свободна
	if get_parent().get("settings_instance"):
		get_parent().settings_instance = null
	
	# Удаляем окно
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
