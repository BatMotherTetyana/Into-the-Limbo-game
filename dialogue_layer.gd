extends CanvasLayer

# Сюда мы будем загружать фразы
var dialogue_lines: Array = []
var current_line_index = 0

# Флаг: печатается ли текст прямо сейчас?
var is_typing = false
# Переменная для анимации текста
var current_tween: Tween

@onready var text_label = $Background/Label
@onready var background = $Background

func _ready():
	# Скрываем диалог при запуске игры
	visible = false

# Эту функцию мы вызовем из сцены игры, чтобы начать разговор
func start_dialogue(lines: Array):
	dialogue_lines = lines
	current_line_index = 0
	visible = true
	show_next_line()

func show_next_line():
	# Если фразы кончились — закрываем окно
	if current_line_index >= dialogue_lines.size():
		visible = false
		return
	
	# Берем текущую фразу
	text_label.text = dialogue_lines[current_line_index]
	
	# Начинаем эффект печатной машинки
	# visible_ratio = 0 (текста не видно), = 1 (весь текст виден)
	text_label.visible_ratio = 0.0
	is_typing = true
	
	# Создаем анимацию (Tween)
	if current_tween: current_tween.kill() # Удаляем старую анимацию, если была
	current_tween = create_tween()
	
	# Рассчитываем время: 0.05 сек на каждую букву
	var duration = text_label.text.length() * 0.05
	current_tween.tween_property(text_label, "visible_ratio", 1.0, duration)
	
	# Когда анимация закончится, говорим, что печатать закончили
	current_tween.finished.connect(func(): is_typing = false)

# Ловим клики мышкой В ЛЮБОМ МЕСТЕ экрана
func _input(event):
	# Если диалог скрыт — не реагируем
	if not visible: return
	
	# Если нажата левая кнопка мыши
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if is_typing:
			# СИТУАЦИЯ 1: Текст ещё печатается -> Мгновенно показываем весь текст
			current_tween.kill() # Останавливаем печать
			text_label.visible_ratio = 1.0 # Показываем всё
			is_typing = false
			
		else:
			# СИТУАЦИЯ 2: Текст уже написан -> Переходим к следующей фразе
			current_line_index += 1
			show_next_line()
