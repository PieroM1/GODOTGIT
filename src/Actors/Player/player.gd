extends CharacterBody2D

@export var velocidad: int = 300
@export var rotation_speed: float = 5.0
@export var laser: PackedScene

var canShoot: bool = true
var life: int = 3

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("derecha"):
		velocity.x = 1
	if Input.is_action_pressed("izquierda"):
		velocity.x = -1
	if Input.is_action_pressed("arriba"):
		velocity.y = -1
	if Input.is_action_pressed("abajo"):
		velocity.y = 1
	
	velocity = velocity.normalized() * velocidad
	
	print(velocity)
	move_and_slide()
	shoot(delta)
	
func shoot(delta):
	var mouse_position = get_global_mouse_position()
	var target_angle = (mouse_position - global_position).angle()
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	if Input.is_action_pressed("disparar") and canShoot:
		$Timer.start()
		canShoot = false
		var newlaser = laser.instantiate()
		newlaser.global_position = $Spawn_Laser.global_position
		newlaser.direction = (get_global_mouse_position() - $Spawn_Laser.global_position).normalized()
		newlaser.rotation_degrees = rotation_degrees
		get_parent().add_child(newlaser)

func _on_timer_timeout():
	canShoot = true

func _on_body_entered(body):
	take_damage(1)

func take_damage(amount):
	life -= amount
	if life <= 0:
		die()
	else:
		update_animation()

func update_animation():
	if life == 2:
		$AnimatedSprite2D.play("mid_life")
	elif life == 1:
		$AnimatedSprite2D.play("low_life")
	update_sprite()

func update_sprite():
	if life == 2:
		$Sprite2D.texture = preload("res://assets/art/Player/PlayerLifeMid.png")
	elif life == 1:
		$Sprite2D.texture = preload("res://assets/art/Player/PlayerLifeLow.png")

func die():
	queue_free()
	# Aquí puedes añadir lógica adicional para manejar la muerte del jugador, como reiniciar el nivel o mostrar una pantalla de game over.
