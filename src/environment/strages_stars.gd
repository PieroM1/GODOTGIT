extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Reproduce la animación "existir" para cada estrella
	for star in get_children():
		if star is AnimatedSprite2D:  # Asegúrate de que cada estrella sea un AnimatedSprite2D
			star.play("existir")       # Reproduce la animación "existir"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
