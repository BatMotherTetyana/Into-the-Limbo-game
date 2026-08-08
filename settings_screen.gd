extends Node2D

var languages = ["ru", "uk", "en"]
var current_lang_index = 0

func _ready():
	# Находим, под каким номером в нашем массиве лежит сохраненный язык
	current_lang_index = languages.find(Global.current_language)
	
	# На всякий случай (если что-то сломалось), ставим английский
	if current_lang_index == -1:
		current_lang_index = 2
		
	update_sliders()
	update_language_visuals()


func _on_visibility_changed():
	if visible == true:
		update_sliders()
		update_language_visuals()


# --- Главная функция синхронизации ползунков ---
func update_sliders():
	if has_node("HSlider2"):
		$HSlider2.value = Global.music_volume
	
	if has_node("HSlider"):
		$HSlider.value = Global.sound_volume


# ==========================================
# --- БЛОК СМЕНЫ ЯЗЫКА ---
# ==========================================

func _on_btn_arrow_left_pressed():
	current_lang_index -= 1
	if current_lang_index < 0:
		current_lang_index = languages.size() - 1
	apply_and_save_language()


func _on_btn_arrow_right_pressed():
	current_lang_index += 1
	if current_lang_index >= languages.size():
		current_lang_index = 0
	apply_and_save_language()


func apply_and_save_language():
	var current_lang = languages[current_lang_index]
	
	# Сохраняем в Global
	Global.current_language = current_lang
	Global.save_settings()
	TranslationServer.set_locale(current_lang) # Меняем язык в движке
	
	# Обновляем картинки
	update_language_visuals()


func update_language_visuals():
	var current_lang = languages[current_lang_index]
	
	if has_node("LanguageFlag"):
		$LanguageFlag.texture = load("res://flag_" + current_lang + ".png")
	
	if has_node("SettingsBackground"):
		$SettingsBackground.texture = load("res://menu_settings_bg_" + current_lang + ".png")


# ==========================================
# --- КНОПКИ ЗАКРЫТИЯ И ПОЛЗУНКИ ---
# ==========================================

func _on_texture_button_pressed():
	# Проверяем, находимся ли мы внутри Паузы
	if get_parent().name == "PauseLayer":
		self.visible = false
		if get_parent().has_node("PauseWindow"):
			get_parent().get_node("PauseWindow").visible = true
	else:
		if "settings_instance" in get_parent():
			get_parent().settings_instance = null
		queue_free()


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
