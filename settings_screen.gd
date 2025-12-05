extends Node2D 

func _ready():
	pass

func _on_texture_button_pressed() -> void:
		# Сообщаем главному меню, что переменная свободна
	if get_parent().get("settings_instance"):
		get_parent().settings_instance = null
	
	# Удаляем окно
	queue_free()
