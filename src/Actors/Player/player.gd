extends CharacterBody2D

@export var velocidad: int = 300
@export var rotation_speed: float = 5.0
@export var laser: PackedScene

var canShoot: bool = true
var life: int = 3
var shoot_s = AudioStreamPlayer2D
var muerte_s = AudioStreamPlayer2D
var daño_s = AudioStreamPlayer2D
var invulnerabilidad:bool = false

func _ready():
	shoot_s = $Shoot
	muerte_s = $Muerte
	daño_s = $Daño
	add_to_group("player")
	$animation_damage.connect("animation_finished", Callable(self, "_on_animation_finished"))
	$Area2D.connect("area_entered", Callable(self, "_on_body_entered"))
	$animation_damage.play("full_sprite")

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
		shoot_s.play()
		get_parent().add_child(newlaser)

func _on_timer_timeout():
	canShoot = true

func die():
	print("TE Moriste ")

func _on_body_entered(area): 
	if area.is_in_group("asteroides") and invulnerabilidad == false:
		match life:
			3:
				daño_s.play()
				await play_mid_life()  # Espera a que termine la animación
				life = life-1
				invulnerabilidad = true
				$Invulnerabilidad.start()
			2:
				daño_s.play()
				await play_low_life()
				life = life-1
				invulnerabilidad = true
				$Invulnerabilidad.start()
			1:
				muerte_s.play()
				life = life-1
				await play_dead()
				life = life-1
				invulnerabilidad = true
				$Invulnerabilidad.start()

func play_mid_life():
	$animation_damage.play("mid_life")  # Reproduce la animación de daño
	await $animation_damage.animation_finished  # Espera a que termine la animación
	$animation_damage.play("mid_sprite")  # Cambia el sprite después de que termine la animación

func play_low_life():
	$animation_damage.play("low_life")  # Reproduce la animación de daño
	await $animation_damage.animation_finished  # Espera a que termine la animación
	$animation_damage.play("low_sprite")  # Cambia el sprite después de que termine la animación

func play_dead():
	$animation_damage.play("dead")  # Reproduce la animación de daño
	await $animation_damage.animation_finished  # Espera a que termine la animación
	die()  # Llama a la función de muerte

func _on_invulnerabilidad_timeout():
	invulnerabilidad = false

func get_life():
	return life
