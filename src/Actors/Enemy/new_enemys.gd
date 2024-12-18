extends CharacterBody2D

# Constantes
const SPEED = 200.0  # Velocidad de movimiento lateral
const FIRE_RATE = 1.5  # Frecuencia de disparo (en segundos)

# Variables
var health = 3  # Vida del enemigo
var direction = 1  # Dirección del movimiento (1 = derecha, -1 = izquierda)
var fire_timer = 0.0  # Temporizador para disparos

# Carga de la escena del láser
@onready var LaserScene = preload("res://src/Actors/Enemy/Laser.tscn")

func _ready() -> void:
	fire_timer = FIRE_RATE

func _physics_process(delta: float) -> void:
	# Movimiento automático de izquierda a derecha
	position.x += SPEED * direction * delta

	# Cambiar de dirección al llegar a los bordes de la pantalla
	if position.x <= 15 or position.x >= get_viewport_rect().size.x - 15:
		direction *= -1

	# Lógica de disparo automático
	fire_timer -= delta
	if fire_timer <= 0:
		fire()
		fire_timer = FIRE_RATE

func fire() -> void:
	# Instanciar el láser desde la escena
	var laser = LaserScene.instantiate()
	laser.position = position + Vector2(-5, 20)  # Ajusta la posición del láser
	get_tree().root.add_child(laser)  # Agregar el láser a la escena principal

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	queue_free()
