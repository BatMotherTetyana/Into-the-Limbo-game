extends CanvasLayer

func _ready():
	$OpenButton.visible = true
	$PauseWindow.visible = false
	
	# ДОБАВЬ ВОТ ЭТУ СТРОЧКУ:
	$SettingsScreen.visible = false


# Эта функция для кнопки В УГЛУ (OpenButton)
func _on_open_button_pressed():
	# Показываем меню, скрываем кнопку
	$PauseWindow.visible = true
	$OpenButton.visible = false
	
	# ЗАМОРАЖИВАЕМ ИГРУ
	get_tree().paused = true


# Эта функция для кнопки ТРЕУГОЛЬНИКА (ResumeButton)
func _on_resume_button_pressed():
	# Скрываем меню, возвращаем кнопку
	$PauseWindow.visible = false
	$OpenButton.visible = true
	
	# РАЗМОРАЖИВАЕМ ИГРУ
	get_tree().paused = false


func _on_menu_button_pressed():
	# 1. ОБЯЗАТЕЛЬНО снимаем паузу!
	# Если это не сделать, главное меню загрузится "замороженным".
	get_tree().paused = false
	
	# 2. Переходим на сцену главного меню
	# Проверь, чтобы имя файла совпадало с твоим (Into_the_Limbo.tscn)
	get_tree().change_scene_to_file("res://Into_the_Limbo.tscn")


func _on_quit_button_pressed():
	# Просто закрываем программу
	get_tree().quit()

# Когда жмем на ШЕСТЕРЕНКУ
func _on_settings_button_pressed():
	# Скрываем меню паузы
	$PauseWindow.visible = false
	# Показываем настройки
	$SettingsScreen.visible = true

# Когда жмем на КРЕСТИК (в настройках)
func _on_close_settings_button_pressed(): # Имя функции может быть другим, зависит от названия кнопки
	# Скрываем настройки
	$SettingsScreen.visible = false
	# Возвращаем меню паузы
	$PauseWindow.visible = true
