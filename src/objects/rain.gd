extends Node2D

@export var asteroid: PackedScene
var screen_size = Vector2(1920, 1080)
var speed = 50  # Velocidad ajustada para un movimiento más lento
var asteroid_timer: Timer
var max_asteroids = 10  # Límite de asteroides en pantalla

func _ready():
	# Crear un temporizador como nodo hijo
	asteroid_timer = Timer.new()
	asteroid_timer.wait_time = 2.0
	asteroid_timer.autostart = true
	asteroid_timer.connect("timeout", Callable(self, "_spawn_asteroid"))
	add_child(asteroid_timer)

func _spawn_asteroid():
	# Comprobar si ya se ha alcanzado el límite de asteroides
	if get_child_count() >= max_asteroids:
		return  # No generar más asteroides si ya alcanzamos el límite

	var asteroid_instance = asteroid.instantiate()

	# Elegir uno de los cuatro bordes
	var side = randi() % 4
	match side:
		0: # Borde superior
			asteroid_instance.position = Vector2(randf_range(0, screen_size.x), 0)
		1: # Borde inferior
			asteroid_instance.position = Vector2(randf_range(0, screen_size.x), screen_size.y)
		2: # Borde izquierdo
			asteroid_instance.position = Vector2(0, randf_range(0, screen_size.y))
		3: # Borde derecho
			asteroid_instance.position = Vector2(screen_size.x, randf_range(0, screen_size.y))

	# Calcular la dirección hacia el centro de la pantalla
	var center_of_screen = Vector2(screen_size.x / 2, screen_size.y / 2)
	var direction = (center_of_screen - asteroid_instance.position).normalized()
	asteroid_instance.direction = direction  # Asignar la dirección al asteroide

	# Añadir el asteroide a la escena
	add_child(asteroid_instance)

func _physics_process(delta):
	for child in get_children():
		if child is Area2D:  # Asegúrate de que sea un asteroide
			# Mueve el asteroide
			child.position += child.direction * speed * delta
			
			# Comprobar si el asteroide sale de la pantalla
			if child.position.x < 0 or child.position.x > screen_size.x or child.position.y < 0 or child.position.y > screen_size.y:
				child.queue_free()  # Destruir el asteroide si sale de la pantalla
