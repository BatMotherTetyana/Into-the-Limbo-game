extends Node2D

# ВАЖНО: Проверь, чтобы имя файла совпадало с тем, что в файловой системе (с нижним подчеркиванием)
const SETTINGS_SCENE = preload("res://settings_screen.tscn")

var settings_instance = null

func _ready():
	# 1. Сначала говорим Диджею: "Хватит шуметь!"
	# Эта команда плавно выключит ветер/лес из прошлой сцены
	AudioManager.stop_ambient(2.0)
	
	# 2. Теперь включаем музыку меню
	# Диджей сам поймет: если играла другая музыка (из игры) — он её заменит.
	# А если музыка меню уже играла (при первом запуске) — он ничего не тронет.
	var menu_music = load("res://menu_sound.mp3") # Проверь, что имя файла верное!
	AudioManager.play_music(menu_music, 3.0)

# Эта функция должна быть подключена к кнопке "Шестеренка"
func _on_settings_button_pressed():
	if settings_instance == null:
		settings_instance = SETTINGS_SCENE.instantiate()
		add_child(settings_instance)


func _on_newgame_pressed():

	SceneTransition.change_scene("res://scene1.tscn")
