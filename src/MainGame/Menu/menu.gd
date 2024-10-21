extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioMenu.play_menu_music()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://src/MainGame/Level/Level1.tscn")


func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://src/MainGame/Menu/creditos.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_instructions_pressed():
	get_tree().change_scene_to_file("res://src/MainGame/Menu/instrucciones.tscn")
