extends Node

# Ссылки на плееры в сцене AudioManager
# ВАЖНО: Убедись, что имена узлов в списке слева точно такие же ($MusicPlayer и $SoundPlayer)
@onready var music_player = $MusicPlayer
@onready var ambient_player = $SoundPlayer

# --- ЧАСТЬ 1: МУЗЫКА (Music) ---
func play_music(new_stream: AudioStream, fade_time: float = 1.0):
	# 1. Если этот трек УЖЕ играет - ничего не делаем
	if music_player.stream == new_stream and music_player.playing:
		return
	
	# 2. Если играет другая музыка - плавно глушим её
	if music_player.playing:
		var tween_out = create_tween()
		tween_out.tween_property(music_player, "volume_db", -80.0, fade_time)
		await tween_out.finished
	
	# 3. Ставим новую пластинку
	music_player.stream = new_stream
	music_player.volume_db = -80.0 # Сразу делаем тихо
	music_player.play()
	
	# 4. Плавно включаем громкость
	var tween_in = create_tween()
	tween_in.tween_property(music_player, "volume_db", 0.0, fade_time)

# --- Добавь это в конец скрипта audio_manager.gd ---

# Функция для плавной остановки музыки
func stop_music(fade_time: float = 1.0):
	if music_player.playing:
		var tween = create_tween()
		# Плавно уводим громкость в минус бесконечность (-80 дБ)
		tween.tween_property(music_player, "volume_db", -80.0, fade_time)
		# Ждем окончания затухания
		await tween.finished
		# Останавливаем плеер полностью
		music_player.stop()
# --- ЧАСТЬ 2: ФОНОВЫЕ ЗВУКИ (Ambient) ---
func play_ambient(new_stream: AudioStream, fade_time: float = 1.0):
	# 1. Если этот фон уже играет - выходим
	if ambient_player.stream == new_stream and ambient_player.playing:
		return
	
	# 2. Если играет другой фон - глушим
	if ambient_player.playing:
		var tween_out = create_tween()
		tween_out.tween_property(ambient_player, "volume_db", -80.0, fade_time)
		await tween_out.finished
	
	# 3. Включаем новый
	ambient_player.stream = new_stream
	ambient_player.volume_db = -80.0
	ambient_player.play()
	
	# 4. Поднимаем громкость
	var tween_in = create_tween()
	tween_in.tween_property(ambient_player, "volume_db", 0.0, fade_time)

# Функция, чтобы выключить фон (пригодится при смене локации)
func stop_ambient(fade_time: float = 1.0):
	if ambient_player.playing:
		var tween = create_tween()
		tween.tween_property(ambient_player, "volume_db", -80.0, fade_time)
		await tween.finished
		ambient_player.stop()
