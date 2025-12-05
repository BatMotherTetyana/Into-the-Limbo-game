extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Подключаем сигнал нажатия кнопки к методу _on_pressed
	self.pressed.connect(_on_pressed)

# Эта функция вызывается, когда кнопка нажимается.
func _on_pressed():
	# Команда, которая завершает работу приложения
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # В кнопке это обычно не нужно
