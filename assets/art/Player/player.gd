extends CharacterBody2D

@export var velocidab:int = 300
@export var rotation_speed : float = 5.0 
@export var laser:PackedScene

var canShoot:bool = true

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
	
	velocity = velocity.normalized()*velocidab
	
	print(velocity)
	move_and_slide()
	shoot(delta)
	
func shoot(delta):
	print(get_global_mouse_position())
	 # Obtener la posición del mouse
	var mouse_position = get_global_mouse_position()
	# Calcular el ángulo hacia el mouse
	var target_angle = (mouse_position - global_position).angle()
	# Interpolar suavemente entre la rotación actual y la rotación objetivo
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	if Input.is_action_pressed("disparar") and canShoot:
		$Timer.start()
		canShoot = false
		var newlaser = laser.instantiate()
		newlaser.global_position = $Spawn_Laser.global_position
		newlaser.direction = get_global_mouse_position() - $Spawn_Laser.global_position
		newlaser.rotation_degrees = rotation_degrees
		get_parent().add_child(newlaser)

func _on_timer_timeout():
	canShoot = true
