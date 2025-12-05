extends TextureButton

# 1. Загружаем сцену настроек (обрати внимание на правильное имя файла!)
const SETTINGS_SCENE = preload("res://settings_screen.tscn")

# Переменная, чтобы запомнить, открыто окно или нет
var settings_instance = null

func _ready():
	pass

# Эту функцию нужно подключить к кнопке настройки (шестеренке)
func _on_settings_button_pressed():
	# Проверяем, не открыто ли уже окно
	if settings_instance == null:
		# Создаем окно
		settings_instance = SETTINGS_SCENE.instantiate()
		# Добавляем его на экран
		add_child(settings_instance)
