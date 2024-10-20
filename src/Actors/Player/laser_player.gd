extends CharacterBody2D

var direction: Vector2

@export var velocidad:int


func _ready():
	$animacion.play("animation_bullet")
	$CollisionShape2D.connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta):
	velocity = direction.normalized()*velocidad
	move_and_slide()

func _on_body_entered(body):
	queue_free()

func _on_timer_timeout():
	queue_free()
