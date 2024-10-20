extends Area2D  # Cambiado a Area2D

var direction: Vector2
@export var velocidad:int

func _ready():
	add_to_group("proyectiles")  # Agregar el proyectil al grupo
	$animacion.play("animation_bullet")
	$CollisionShape2D.connect("area_entered", Callable(self, "_on_body_entered"))  # Usando Callable correctamente

func _on_body_entered(area):
	if area.is_in_group("asteroids"):  # Asegúrate de que los asteroides estén en este grupo
		area.play_explosion_animation()  # Llama al método de explosión del asteroide
		queue_free()  # Destruye el proyectil

func _process(delta):
	position += direction.normalized() * velocidad * delta  # Mueve el proyectil

func _on_timer_timeout():
	queue_free()
