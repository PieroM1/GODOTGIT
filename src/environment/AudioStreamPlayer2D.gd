extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
		# Carga tu archivo de audio aquí
	stream = load("res://assets/audio/Music/La Choza de Crazy Witch.ogg")  # Ajusta la ruta a tu archivo
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
