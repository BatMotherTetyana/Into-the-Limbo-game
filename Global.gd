extends Node

# Путь к файлу сохранений на компьютере игрока
const SAVE_PATH = "user://settings.cfg"
var config = ConfigFile.new()

# Громкость по умолчанию (1.0 = 100%)
var music_volume = 1.0
var sound_volume = 1.0

func _ready():
	load_settings()

func save_settings():
	# Записываем данные в файл
	config.set_value("Audio", "music", music_volume)
	config.set_value("Audio", "sound", sound_volume)
	config.save(SAVE_PATH)

func load_settings():
	# Пытаемся загрузить файл
	var err = config.load(SAVE_PATH)
	if err == OK:
		music_volume = config.get_value("Audio", "music", 1.0)
		sound_volume = config.get_value("Audio", "sound", 1.0)
		
		# Применяем громкость к шинам (каналам)
		# AudioServer работает с децибелами, поэтому переводим линейное (0-1) в дБ
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), linear_to_db(sound_volume))
