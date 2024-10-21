extends Node2D

var timer: float = 0.0  # Variable para almacenar el tiempo transcurrido
var timer_label: Label  # Asume que el Label se llama "Label"
@onready var you_win_s = AudioStreamPlayer2D

func _ready():
	timer_label = $Camera2D2/Tiempo
	you_win_s = $YouWin
	timer_label.text = "00:00"  # Inicializa el Label en 00:00
	
	var timer1 = Timer.new()
	timer1.wait_time = 5.0  # Establecer el tiempo para el temporizador
	timer1.one_shot = true  # Asegúrate de que el temporizador no se reinicie
	timer1.connect("timeout", Callable(self, "_on_timer_timeout"))  # Conectar la señal de tiempo
	add_child(timer1)
	timer1.start()  # Iniciar el temporizador

func _process(delta):
	timer += delta  # Aumenta el tiempo transcurrido
	update_timer_label()
	#end_game()  # Llama a tu función para terminar el juego
func update_timer_label():
	var seconds = int(timer) % 60
	var minutes = int(timer) / 60
	timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)  # Actualiza el texto del Label

func _on_timer_timeout():
	print("Intentando reproducir sonido")  # Verifica que se llame a esta función
	you_win_s.play()  # Reproduce el sonido cuando el temporizador se agote
	print("El sonido se ha reproducido.")
