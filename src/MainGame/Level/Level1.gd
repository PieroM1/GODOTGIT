extends Node2D

var timer: float = 0.0  # Variable para almacenar el tiempo transcurrido
var timer_label: Label  # Asume que el Label se llama "Label"

func _ready():
	AudioMenu.stop_menu_music()
	timer_label = $Camera2D2/Tiempo
	timer_label.text = "00:00"  # Inicializa el Label en 00:00

func _process(delta):
	timer += delta  # Aumenta el tiempo transcurrido
	update_timer_label()
	if timer >= 120:
		print("El juego ha terminado.")
	#end_game()  # Llama a tu función para terminar el juego

func update_timer_label():
	var seconds = int(timer) % 60
	var minutes = int(timer) / 60
	timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)  # Actualiza el texto del Label
