extends Node

# Путь к файлу сохранений на компьютере игрока
const SAVE_PATH = "user://settings.cfg"
var config = ConfigFile.new()

# Громкость по умолчанию (1.0 = 100%)
var music_volume = 1.0
var sound_volume = 1.0

# Язык (пустая строка означает, что мы еще не определяли язык)
var current_language = "" 

func _ready():
	load_settings()

func save_settings():
	# Записываем данные в файл
	config.set_value("Audio", "music", music_volume)
	config.set_value("Audio", "sound", sound_volume)
	config.set_value("Language", "current", current_language) # Сохраняем язык!
	config.save(SAVE_PATH)

func load_settings():
	# Пытаемся загрузить файл
	var err = config.load(SAVE_PATH)
	if err == OK:
		music_volume = config.get_value("Audio", "music", 1.0)
		sound_volume = config.get_value("Audio", "sound", 1.0)
		current_language = config.get_value("Language", "current", "") # Читаем язык
	else:
		current_language = "" # Если файла нет (первый запуск)
		
	# Применяем громкость
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), linear_to_db(sound_volume))
	
	# === МАГИЯ ОПРЕДЕЛЕНИЯ ЯЗЫКА ===
	if current_language == "":
		# Если язык еще не выбран (первый запуск), спрашиваем у Windows
		var os_lang = OS.get_locale_language() # Вернет "ru", "uk", "en" и т.д.
		
		if os_lang == "uk":
			current_language = "uk"
		elif os_lang == "ru":
			current_language = "ru"
		else:
			current_language = "en" # Английский для всех остальных (китайцев, немцев и т.д.)
			
		save_settings() # Сохраняем, чтобы больше не спрашивать систему
	
	# Говорим самому движку Godot, какой сейчас язык (пригодится для перевода текста)
	TranslationServer.set_locale(current_language)
