extends Node2D

func _ready():
	# При первом создании окна сразу обновляем ползунки
	update_sliders()

# Эта функция сработает, когда ты нажмешь "Шестеренку" в паузе (окно станет видимым)
func _on_visibility_changed():
	if visible == true:
		update_sliders()

# --- Главная функция синхронизации ---
func update_sliders():
	# Мы берем данные из Global и передаем их слайдерам
	
	# Судя по твоему коду ниже, HSlider2 — это МУЗЫКА
	if has_node("HSlider2"):
		$HSlider2.value = Global.music_volume
	
	# А HSlider — это ЗВУКИ
	if has_node("HSlider"):
		$HSlider.value = Global.sound_volume


func _on_texture_button_pressed():
	# Проверяем, находимся ли мы внутри Паузы
	if get_parent().name == "PauseLayer":
		# ВАРИАНТ 1: МЫ В ПАУЗЕ
		self.visible = false
		# Возвращаем меню паузы
		if get_parent().has_node("PauseWindow"):
			get_parent().get_node("PauseWindow").visible = true
		
	else:
		# ВАРИАНТ 2: МЫ В ГЛАВНОМ МЕНЮ
		if "settings_instance" in get_parent():
			get_parent().settings_instance = null
		queue_free()


# --- Твои функции для изменения громкости ---

func _on_h_slider_2_value_changed(value):
	# Музыка (Music)
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	Global.music_volume = value
	Global.save_settings()


func _on_h_slider_value_changed(value):
	# Звуки (Sounds)
	var bus_index = AudioServer.get_bus_index("Sounds") 
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	Global.sound_volume = value
	Global.save_settings()
