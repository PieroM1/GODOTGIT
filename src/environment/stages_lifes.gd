extends Node2D

var lives = []

var player:CharacterBody2D
var player_life:int
var previous_player_life: int

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Level1/Player")
	lives.append($Life)
	lives.append($Life2)
	lives.append($Life3)
	for life in lives:
		life._play_existir()
	
	previous_player_life = player.get_life()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	player_life = player.get_life()
	
	if player_life < previous_player_life:
		# Reproducir la animación de pérdida de vida y hacer invisible el nodo correspondiente
		if previous_player_life - 1 < len(lives):
			var life_node = lives[previous_player_life - 1]
			life_node._play_lose_life()
			
		previous_player_life = player_life
	print(player_life)
	


