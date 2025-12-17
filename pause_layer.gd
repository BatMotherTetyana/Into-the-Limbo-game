extends CanvasLayer

func _ready():
	# При старте игры:
	# 1. Показываем маленькую кнопку
	$OpenButton.visible = true
	# 2. Скрываем всё окно паузы (вместе с фоном и кнопками)
	$PauseWindow.visible = false


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
