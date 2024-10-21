extends Area2D  # Cambiado a Area2D

@export var speed: float = 100.0
var direction: Vector2
var destroy_s : AudioStreamPlayer2D

func _ready():
	destroy_s = $Destroy
	add_to_group("asteroides")
	$spr_asteroid.connect("animation_finished", Callable(self, "_on_animation_finished"))
	$spr_asteroid.play("existir")
func _process(delta):
	position += direction * speed * delta  # Mueve el objeto
	
	# Verifica si hay colisiones
	for area in get_overlapping_areas():
		if area.is_in_group("proyectiles"):  # Verifica si colisionó con un proyectil
			direction = Vector2.ZERO  # Detiene el asteroide
			speed = 0  # Detiene el asteroide
			collision_layer = 0  # Desactiva la colisión
			collision_mask = 0  # Desactiva la colisión
			play_explosion_animation()  # Llama al método de explosión
			area.queue_free()  # Destruye el proyectil

func play_explosion_animation():
	$spr_asteroid.play("explotar")
	destroy_s.play()  # Reproduce la animación de explosión

func _on_animation_finished():
	queue_free()  # Destruye el asteroide después de la animación
