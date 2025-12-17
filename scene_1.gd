extends Node2D

func _ready():
	# 1. Загружаем ФОНОВЫЙ ЗВУК (ветер, гул, лес...)
	var ambient_sound = load("res://wind_sound.mp3")
	
	# 2. Просим Диджея включить Эмбиент
	AudioManager.play_ambient(ambient_sound, 3.0)
	
	# 2. Глушим музыку из МЕНЮ
	# Ставим время затухания, например, 2 секунды. 
	# Пока экран светлеет после шторки, музыка будет плавно исчезать.
	AudioManager.stop_music(2.0)
	
	# 1. Ждем 3 секунды
	await get_tree().create_timer(3.0).timeout
	
	# 2. Список фраз для диалога
	var my_text = [
		"Consciousness returns not with a sudden flash, but as a viscous, slow ascent from the depths of a non-existent ocean, where eyelids part to sever the veil of non-being, and the world reveals itself in frozen grisaille, bereft of the breath of life.",
		"Dark blades of grass, akin to frozen strings, barely graze bare feet—a touch filled with a cold, detached tenderness—while a directionless wind slides across the skin, offering no refreshment, but rather licking away the remnants of warmth and carrying off shards of the past.",
		"Memory melts like hoarfrost on black stone; names, faces, causes, and consequences dissolve into an internal fog that thickens with every passing second, leaving the mind crystal clear yet frighteningly empty, where thoughts depart before they are truly born, consumed by the whitish haze of oblivion.",
		"Around stretches a boundless steppe—an ocean of silence over which, in place of the sun, reigns the deathly pale disc of the moon, whose radiance is paradoxical: it offers no warmth, yet floods the space with an unnatural, piercing clarity, allowing the gaze to slide far ahead, to where the horizon is pierced by black peaks",
		"There, in the distance, lurks the forest—a jagged wall of shadows, ancient and sinister, like a scar upon the body of the night, and from these silhouettes emanates a vibration of silent anticipation.",
		"The place breathes a strangeness impossible to clothe in simple emotions;",
		"...it is neither fear nor peace, but something interstitial—a sensation that the world around is merely a thin set decoration stretched over primordial chaos.",
		"A viscous premonition whispers that reality here is woven from shreds of others' dreams, the earth beneath feels too solid for soil, and the air too heavy for breath.",
		"In this desolate space, time itself is tied in a knot, extinguishing thoughts before they can shape into questions: the steppe waits, the forest watches, and the fog within echoes the fog without, erasing the boundaries between the observer and the observed."
	]
	
	# 3. Запускаем диалог!
	# (Убедись, что имя узла DialogueLayer правильное)
	$DialogueLayer.start_dialogue(my_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
