extends Node2D

# ВАЖНО: Проверь, чтобы имя файла совпадало с тем, что в файловой системе (с нижним подчеркиванием)
const SETTINGS_SCENE = preload("res://settings_screen.tscn")

var settings_instance = null

func _ready():
	pass

# Эта функция должна быть подключена к кнопке "Шестеренка"
func _on_settings_button_pressed():
	if settings_instance == null:
		settings_instance = SETTINGS_SCENE.instantiate()
		add_child(settings_instance)


func _on_newgame_pressed():
	# Меняем сцену на уровень 1
	# ВАЖНО: Проверь, чтобы имя файла в кавычках точно совпадало с именем твоей сохраненной сцены!
	get_tree().change_scene_to_file("res://scene1.tscn")
