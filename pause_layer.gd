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
func _unhandled_input(event):
	# Проверяем нажатие кнопки ESCAPE
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		
		# СИТУАЦИЯ 1: Открыты НАСТРОЙКИ
		if $SettingsScreen.visible:
			# Закрываем настройки, возвращаем меню паузы (имитируем нажатие крестика)
			_on_close_settings_button_pressed() 
			# (Убедись, что имя функции _on_close... совпадает с тем, что у тебя в коде!)
			
		# СИТУАЦИЯ 2: Открыто само МЕНЮ ПАУЗЫ
		elif $PauseWindow.visible:
			# Возвращаемся в игру (имитируем кнопку Resume)
			# Если у тебя есть функция _on_resume_button_pressed, вызови её:
			# _on_resume_button_pressed()
			
			# Или просто напиши код закрытия вручную:
			$PauseWindow.visible = false
			$OpenButton.visible = true # Если есть кнопка открытия
			get_tree().paused = false
			
		# СИТУАЦИЯ 3: ИГРА ИДЕТ (всё закрыто)
		else:
			# Ставим на паузу
			$PauseWindow.visible = true
			$OpenButton.visible = false
			get_tree().paused = true
