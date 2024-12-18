extends Area2D

# Constantes
const LASER_SPEED = 300.0  # Velocidad del láser

func _process(delta: float) -> void:
	# Mover el láser hacia abajo
	position.y += LASER_SPEED * delta

	# Si el láser sale de la pantalla, eliminarlo
	if position.y > get_viewport_rect().size.y:
		queue_free()

func _on_area_entered(body):
	# Detectar colisiones
	if body.is_in_group("player"):  # Verifica si el objeto tiene el grupo "player"
		body.take_damage(1)  # Aplica daño al jugador
		queue_free()  # Elimina el láser
