extends Camera2D

var jugador
var suavizado = 0.010

# Called when the node enters the scene tree for the first time.
func _ready():
	jugador = get_node("/root/Level1/Player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jugador:
		position = lerp(position, jugador.position, suavizado)
