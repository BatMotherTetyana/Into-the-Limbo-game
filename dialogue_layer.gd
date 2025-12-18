extends CanvasLayer

signal dialogue_finished

# --- ЗАГРУЗКА ШРИФТА ---
# Укажи путь к своему пиксельному шрифту!
var button_font = preload("res://dogicapixel.ttf") 

# ... (дальше твои остальные переменные: bg_narrator, text_narrator и т.д.)
# --- ССЫЛКИ НА УЗЛЫ ---
@onready var bg_narrator = $BackgroundNarrator
@onready var text_narrator = $TextNarrator

@onready var bg_character = $BackgroundCharacter
@onready var text_character = $TextCharacter
@onready var name_label = $NameLabel

# Переменные для логики текста
var dialogue_lines: Array = []
var current_line_index = 0
var is_typing = false
var current_tween: Tween

# Сюда мы запоминаем, в какой Label писать прямо сейчас
var active_label: Label = null

# Флаг: закрывать ли окно после окончания диалога?
var should_close: bool = true

func _ready():
	visible = false
	# Скрываем всё при старте
	if bg_narrator: bg_narrator.visible = false
	if text_narrator: text_narrator.visible = false
	if bg_character: bg_character.visible = false
	if text_character: text_character.visible = false
	if name_label: name_label.visible = false

# --- ГЛАВНАЯ ФУНКЦИЯ ЗАПУСКА ---
# Мы добавили параметр close_after (по умолчанию true - закрывать)
func start_dialogue(lines: Array, character_name: String = "", close_after: bool = true):
	dialogue_lines = lines
	current_line_index = 0
	should_close = close_after # Запоминаем: закрывать в конце или нет?
	
	visible = true # <--- ВОТ ЭТА ВАЖНАЯ СТРОЧКА, КОТОРАЯ ОТКРЫВАЕТ ОКНО!
	
	# --- НАСТРОЙКА ВНЕШНЕГО ВИДА ---
	
	if character_name == "":
		# === РЕЖИМ АВТОРА ===
		if bg_narrator: bg_narrator.visible = true
		if text_narrator: text_narrator.visible = true
		
		if bg_character: bg_character.visible = false
		if text_character: text_character.visible = false
		if name_label: name_label.visible = false
		
		active_label = text_narrator
		
	else:
		# === РЕЖИМ ПЕРСОНАЖА ===
		if bg_narrator: bg_narrator.visible = false
		if text_narrator: text_narrator.visible = false
		
		if bg_character: bg_character.visible = true
		if text_character: text_character.visible = true
		
		if name_label: 
			name_label.visible = true
			name_label.text = character_name
		
		active_label = text_character
	
	show_next_line()

func show_next_line():
	# Если фразы кончились
	if current_line_index >= dialogue_lines.size():
		
		# ПРОВЕРЯЕМ: Нужно ли закрывать окно?
		if should_close == true:
			visible = false # Закрываем полностью
		else:
			pass # Оставляем висеть открытым (для смены позы)
			
		dialogue_finished.emit() # Сигнал посылаем всегда!
		return
	
	# Если активного текста нет (ошибка), выходим
	if active_label == null: return

	# Пишем текст
	active_label.text = dialogue_lines[current_line_index]
	active_label.visible_ratio = 0.0
	is_typing = true
	
	if current_tween: current_tween.kill()
	current_tween = create_tween()
	
	var duration = active_label.text.length() * 0.05
	current_tween.tween_property(active_label, "visible_ratio", 1.0, duration)
	
	current_tween.finished.connect(func(): is_typing = false)

func _unhandled_input(event):
	if not visible: return
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_typing and active_label:
			current_tween.kill()
			active_label.visible_ratio = 1.0
			is_typing = false
		else:
			current_line_index += 1
			show_next_line()
			
			# ... (твой старый код) ...

# Сигнал, который скажет сцене 1, что игрок выбрал кнопку
signal choice_made(index: int)

@onready var choice_menu = $ChoiceMenu # Ссылка на контейнер

# Функция создания кнопок
func show_choices(options: Array):
	# 1. Удаляем старые кнопки
	for child in choice_menu.get_children():
		child.queue_free()
	
	# 2. Создаем новые
	for i in range(options.size()):
		var btn = Button.new()
		btn.text = options[i]
		
		# --- ВОТ ТУТ ДОБАВЛЯЕМ ШРИФТ ---
		
		# 1. Устанавливаем сам файл шрифта
		btn.add_theme_font_override("font", button_font)
		
		# 2. (Опционально) Меняем размер шрифта, если нужно покрупнее
		btn.add_theme_font_size_override("font_size", 24)
		
		# 3. (Опционально) Можно поменять цвет текста
		# btn.add_theme_color_override("font_color", Color(1, 1, 1)) # Белый
		# btn.add_theme_color_override("font_hover_color", Color(1, 1, 0)) # Желтый при наведении
		
		# -------------------------------
		
		btn.pressed.connect(_on_button_pressed.bind(i))
		choice_menu.add_child(btn)
	
	choice_menu.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Внутренняя функция при нажатии
func _on_button_pressed(index: int):
	# Скрываем меню
	choice_menu.visible = false
	
	# Сообщаем игре: "Выбрана кнопка номер [index]!"
	choice_made.emit(index)
