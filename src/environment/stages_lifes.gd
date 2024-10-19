extends Node2D

var lives = []
# Called when the node enters the scene tree for the first time.
func _ready():
	#Inicializar los corazones y aniadir al array
	lives.append($Life)
	lives.append($Life2)
	lives.append($Life3)
	 # Reproduce la animación "existir" para cada corazón
	for life in lives:
		var animated_sprite = life.get_node("ani_spr_life") # Accede al AnimatedSprite2D dentro de Node2D
		if animated_sprite:  # Verifica que el nodo existe
			animated_sprite.play("existir")  # Reproduce la animación "existir"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
