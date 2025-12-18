extends Node2D

# --- ССЫЛКИ НА УЗЛЫ ---
# Контейнер героя и его слои
@onready var hero_container = $HeroContainer
@onready var color_layer = $HeroContainer/ColorLayer
@onready var black_layer = $HeroContainer/BlackLayer

# Виньетка (Черный экран для переходов)
# Убедись, что у тебя в сцене есть ColorRect с именем BlackScreen!
@onready var black_screen = $BlackScreen 
@onready var vignette = $Vignette # (Или путь к ней, если она в CanvasLayer)

# --- ЗАГРУЗКА СПРАЙТОВ (ПОЗЫ) ---
# preload загружает картинки сразу при старте игры - это работает быстрее
var bg_location2 = preload("res://bg_scene2.png") # Замени на имя файла
var sound_location2 = preload("res://wind-through-the-leaves.mp3")
var sound_location3 = preload("res://leaves-rustle.mp3")

# ПОЗА 1 (Нейтральная / Спокойная)
var pose1_color = preload("res://limbo1.png")
var pose1_black = preload("res://limbo1b.png")

# ПОЗА 2 (Удивление / Страх / Другая эмоция)
var pose2_color = preload("res://limbo2.png")
var pose2_black = preload("res://limbo2b.png")

# ПОЗА 3
var pose3_color = preload("res://limbo3.png")
var pose3_black = preload("res://limbo3b.png")

# ПОЗА 4
var pose4_color = preload("res://limbo4.png")
var pose4_black = preload("res://limbo4b.png")

# ПОЗА 5
var pose5_color = preload("res://limbo5.png")
var pose5_black = preload("res://limbo5b.png")

# ПОЗА 6
var pose6_color = preload("res://limbo6.png")
var pose6_black = preload("res://limbo6b.png")


# --- НАСТРОЙКИ КАРМЫ (ПРОЗРАЧНОСТИ) ---
# 1.0 = Полностью черный силуэт
# 0.0 = Полностью цветной спрайт
var current_darkness: float = 1.0 
const STEP: float = 0.2 # Шаг изменения (20%)


func _ready():
	# --- 0. НАЧАЛЬНАЯ ПОДГОТОВКА ---
	# Скрываем героя, пока не наступит его время
	hero_container.visible = false
	# Убеждаемся, что сам герой внутри контейнера черный (верхний слой непрозрачен)
	black_layer.modulate.a = 1.0
	current_darkness = 1.0
	# Экран прозрачный (видим фон)
	black_screen.color.a = 0.0
	
	
	# --- 1. АУДИО СТАРТ ---
	var ambient_sound = load("res://wind_sound.mp3")
	AudioManager.play_ambient(ambient_sound, 3.0)
	AudioManager.stop_music(2.0) # Глушим музыку меню
	
	
	# --- 2. ПЕРВЫЙ ДИАЛОГ ---
	await get_tree().create_timer(3.0).timeout # Ждем 3 секунды
	
	var my_text = [
		"Consciousness returns not with a sudden flash, but as a viscous, slow ascent from the depths of a non-existent ocean, where eyelids part to sever the veil of non-being, and the world reveals itself in frozen grisaille, bereft of the breath of life.",
		"Dark blades of grass, akin to frozen strings, barely graze bare feet—a touch filled with a cold, detached tenderness—while a directionless wind slides across the skin, offering no refreshment, but rather licking away the remnants of warmth and carrying off shards of the past.",
		"Memory melts like hoarfrost on black stone; names, faces, causes, and consequences dissolve into an internal fog that thickens with every passing second, leaving the mind crystal clear yet frighteningly empty, where thoughts depart before they are truly born, consumed by the whitish haze of oblivion.",
		"Around stretches a boundless steppe—an ocean of silence over which, in place of the sun, reigns the deathly pale disc of the moon, whose radiance is paradoxical: it offers no warmth, yet floods the space with an unnatural, piercing clarity, allowing the gaze to slide far ahead, to where the horizon is pierced by black peaks.",
		"There, in the distance, lurks the forest—a jagged wall of shadows, ancient and sinister, like a scar upon the body of the night, and from these silhouettes emanates a vibration of silent anticipation.",
		"The place breathes a strangeness impossible to clothe in simple emotions;",
		"...it is neither fear nor peace, but something interstitial—a sensation that the world around is merely a thin set decoration stretched over primordial chaos.",
		"A viscous premonition whispers that reality here is woven from shreds of others' dreams, the earth beneath feels too solid for soil, and the air too heavy for breath.",
		"In this desolate space, time itself is tied in a knot, extinguishing thoughts before they can shape into questions: the steppe waits, the forest watches, and the fog within echoes the fog without, erasing the boundaries between the observer and the observed."
	]
	
	# Запускаем диалог
	$DialogueLayer.start_dialogue(my_text)
	
	# ВАЖНО: Ждем, пока игрок дочитает весь текст!
	# (Для этого мы добавляли signal dialogue_finished в скрипт диалога)
	await $DialogueLayer.dialogue_finished
	
	# --- 1. ПОЯВЛЕНИЕ ВИНЬЕТКИ ---
	# Создаем тревожную атмосферу
	# (Убедись, что перед этим vignette.modulate.a = 0.0)
	var tween0 = create_tween()
	tween0.tween_property(vignette, "modulate:a", 1.0, 1.0) # Появляется за 2 сек
	await tween0.finished
	await get_tree().create_timer(3.0).timeout
	# --- 2. КОРОТКИЙ ДИАЛОГ С ВИНЬЕТКОЙ ---
	var scared_text = [
		"The gaze, straining to pierce the gray shroud and catch even a flicker of movement at the forest's edge, suddenly snags on something blacker than the night itself.", 
		"There, where the air feels especially dense, a hollow void emerges—as if the very fabric of twilight has torn apart to reveal a primordial emptiness.",
		"The shadow has coalesced into a tall, tense figure frozen amidst the grass, like an unknown beast caught in a moment of absolute stillness.",
		"The sharp, towering peaks of ears, resembling the tines of a shadowy crown, and the smooth curve of a long tail are divined more by intuition than by clear sight.",
		"The fog clings to this form, now blurring its edges into a haze, now retreating to let the blackness emerge with frightening clarity.",
		"And suddenly, this unnatural stillness is broken. The black silhouette detaches from the monolithic wall of the forest and begins a smooth glide forward.",
		"Tall dark grass conceals its base, masking the movement of legs, giving rise to the eerie sensation that the figure is not walking, but drifting through black waves of grass—slicing through the viscous gloom without disturbing its dead silence.",
		"With every dragging moment, the black spot gains density, its contours sharpening.",
		"The distance shrinks inexorably, and from this silent, inevitable advance, an inner chill deepens, finally seizing the breath entirely."
		]
	$DialogueLayer.start_dialogue(scared_text)
	await $DialogueLayer.dialogue_finished
	# --- 3. КАТ-СЦЕНА (ПОЯВЛЕНИЕ ГЕРОЯ) ---
	
	# Затемняем экран в черноту за 2 секунды
	var tween = create_tween()
	tween.tween_property(black_screen, "color:a", 1.0, 1.0)
	await tween.finished
	
	# Пока темно - включаем героя (но его пока не видно из-за черного экрана)
	hero_container.visible = true
	vignette.visible = false
	
	# --- 4. ВКЛЮЧАЕМ МУЗЫКУ ---
	# Запускаем музыку только когда герой появился
	var level_music = load("res://music_box.mp3") # Укажи свой файл!
	AudioManager.play_music(level_music)
	
	# Ждем 2 секунды в полной темноте (для атмосферы)
	await get_tree().create_timer(2.0).timeout
	
	# Возвращаем картинку (убираем черноту экрана)
	tween = create_tween()
	tween.tween_property(black_screen, "color:a", 0.0, 2.0) # Медленно, за 3 сек
	await tween.finished
	
	await get_tree().create_timer(2.0).timeout
	
	var Limbo_voice = [
		"...",
		"Hi..",
		]
	$DialogueLayer.start_dialogue(Limbo_voice, "Limbo")
	await $DialogueLayer.dialogue_finished
	# --- 3. КАТ-СЦЕНА (ПОЯВЛЕНИЕ ГЕРОЯ) ---
	
	await get_tree().create_timer(1).timeout
	change_hero_pose(pose5_color, pose5_black)
	await get_tree().create_timer(2).timeout
	
	
	change_hero_pose(pose4_color, pose4_black)
	var part1 = ["Are you new around here?"]
	$DialogueLayer.start_dialogue(part1, "Limbo", false)
	await $DialogueLayer.dialogue_finished
	
	change_hero_pose(pose2_color, pose2_black) 
	var part2 = ["It's been ages since I last encountered a human soul like yours..."]
	$DialogueLayer.start_dialogue(part2, "Limbo", false)
	await $DialogueLayer.dialogue_finished
	
	change_hero_pose(pose5_color, pose5_black) 
	var part3 = ["What is your name?"]
	$DialogueLayer.start_dialogue(part3, "Limbo", true)
	await $DialogueLayer.dialogue_finished
	
	await get_tree().create_timer(2).timeout
	
	change_hero_pose(pose6_color, pose6_black)
	var part4 = ["Although...", "Anyway, it hardly matters."]
	$DialogueLayer.start_dialogue(part4, "Limbo", false)
	await $DialogueLayer.dialogue_finished
	
	change_hero_pose(pose3_color, pose3_black) 
	var part5 = ["I suppose you'd benefit from somewhere cozier than this forsaken steppe, wouldn't you? Haha..."]
	$DialogueLayer.start_dialogue(part5, "Limbo", false)
	await $DialogueLayer.dialogue_finished
	
	change_hero_pose(pose4_color, pose4_black) 
	var part6 = ["Come with me—I'll tell you all about this place and how you ended up here along the way."]
	$DialogueLayer.start_dialogue(part6, "Limbo", true)
	await $DialogueLayer.dialogue_finished
	
	await get_tree().create_timer(2).timeout
	
	# ... (Твой предыдущий диалог закончился) ...
	
	# --- 1. ЗАТЕМНЕНИЕ (УХОД В ТЕМНОТУ) ---
	tween = create_tween()
	# Затемняем экран за 2 секунды
	tween.tween_property(black_screen, "color:a", 1.0, 2.0)
	
	# Параллельно глушим старый звук ветра/леса (если AudioManager поддерживает это)
	# Если просто запустить новый звук с fade_time, он должен сам перекрыть старый.
	AudioManager.play_ambient(sound_location2, 2.0) 
	
	# Ждем, пока экран станет черным
	await tween.finished
	
	
	# --- 2. СМЕНА ДЕКОРАЦИЙ (В ТЕМНОТЕ) ---
	# Пока никто не видит, меняем картинку фона.
	$BgScene1.texture = bg_location2
	
	# === ВОТ ТУТ ДВИГАЕМ ГЕРОЯ ===
	# Если экран 1920 шириной, то центр ~960.
	# Чтобы поставить слева: пробуй 400 или 500.
	# Чтобы поставить справа: пробуй 1400 или 1500.
	
	hero_container.position.x = 400  # <--- ДОБАВЬ ЭТУ СТРОЧКУ (Поставь персонажа влево)
	
	# (Если нужно поднять или опустить, меняй Y)
	# hero_container.position.y = 800
	
	
	# Ждем пару секунд для атмосферы...
	await get_tree().create_timer(2.0).timeout
	
	
	# Тут можно сменить и позу героя, если нужно, или скрыть его
	hero_container.visible = false 
	
	
	# --- 3. ВЫХОД ИЗ ТЕМНОТЫ ---
	tween = create_tween()
	# Делаем экран прозрачным снова
	tween.tween_property(black_screen, "color:a", 0.0, 2.0)
	await tween.finished
	change_hero_pose(pose1_color, pose1_black) 
	await get_tree().create_timer(2.0).timeout
	hero_container.visible = true 
	# --- 4. ПРОДОЛЖЕНИЕ ---
	# Теперь можно запускать новый диалог
	var new_text = ["Где я теперь?", "Здесь всё по-другому..."]
	$DialogueLayer.start_dialogue(new_text, "Limbo")
	
# --- ФУНКЦИИ УПРАВЛЕНИЯ ГЕРОЕМ ---

# 1. Функция изменения Кармы (шагов проявления)
# Вызывай change_karma(true), если ответ правильный
# Вызывай change_karma(false), если ответ неправильный
func change_karma(is_correct: bool):
	if is_correct:
		current_darkness -= STEP # Светлеем (проявляем цвет)
	else:
		current_darkness += STEP # Темнеем (прячем цвет)
	
	# Не даем уйти за границы (меньше 0 или больше 1)
	current_darkness = clamp(current_darkness, 0.0, 1.0)
	
	# Плавно меняем прозрачность черного слоя
	var tween = create_tween()
	tween.tween_property(black_layer, "modulate:a", current_darkness, 0.5)
	
	print("Текущая тьма героя: ", current_darkness)

# 2. Функция смены позы (меняет картинки сразу на двух слоях)
func change_hero_pose(color_tex: Texture2D, black_tex: Texture2D):
	color_layer.texture = color_tex
	black_layer.texture = black_tex
