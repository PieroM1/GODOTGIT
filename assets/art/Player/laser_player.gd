extends CharacterBody2D

var direction: Vector2

@export var velocidab:int

func _physics_process(delta):
	velocity = direction.normalized()*velocidab
	move_and_slide()
