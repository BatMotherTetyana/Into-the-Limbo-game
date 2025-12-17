extends CanvasLayer

func change_scene(target: String) -> void:
	# 1. Играем анимацию затемнения (появляется черный экран)
	$AnimationPlayer.play("dissolve")
	
	# 2. Ждем, пока анимация закончится
	await $AnimationPlayer.animation_finished
	
	# 3. В этот момент экран полностью черный. Меняем сцену!
	get_tree().change_scene_to_file(target)
	
	# 4. Играем анимацию задом наперед (черный экран исчезает)
	$AnimationPlayer.play_backwards("dissolve")
