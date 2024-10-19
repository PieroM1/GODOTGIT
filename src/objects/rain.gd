extends Node2D

@export var asteroid_scene: PackedScene  # Asegúrate de asignarlo en el editor de Godot
var screen_size = Vector2(1920, 1080)
var speed = 50  # Velocidad ajustada para un movimiento más lento
var asteroids = []  # Vector para almacenar los asteroides
var max_asteroids = 10  # Número máximo de asteroides en pantalla
var asteroid_timer: Timer

func _ready():
	# Crear un temporizador como nodo hijo
	asteroid_timer = Timer.new()
	asteroid_timer.wait_time = 2.0
	asteroid_timer.autostart = true
	asteroid_timer.connect("timeout", Callable(self, "_spawn_asteroid"))
	add_child(asteroid_timer)

func _spawn_asteroid():
	if asteroids.size() < max_asteroids:  # Solo crear un asteroide si no se ha alcanzado el límite
		var asteroid_instance = asteroid_scene.instantiate()  # Instanciar el asteroide
		asteroids.append(asteroid_instance)  # Agregar a la lista de asteroides

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
	for i in range(asteroids.size() - 1, -1, -1):  # Iterar sobre la lista de asteroides en orden inverso
		var asteroid_instance = asteroids[i]
		if is_instance_valid(asteroid_instance):  # Verifica que el asteroide sigue siendo válido
			# Mueve el asteroide
			asteroid_instance.position += asteroid_instance.direction * speed * delta
			
			# Comprobar si el asteroide sale de la pantalla
			if asteroid_instance.position.x < 0 or asteroid_instance.position.x > screen_size.x or asteroid_instance.position.y < 0 or asteroid_instance.position.y > screen_size.y:
				asteroid_instance.queue_free()  # Destruir el asteroide si sale de la pantalla
				asteroids.erase(asteroid_instance)  # Eliminarlo de la lista
