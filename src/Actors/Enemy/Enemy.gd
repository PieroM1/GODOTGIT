extends CharacterBody2D

@export var initial_orbit_distance: float = 300.0
@export var orbit_speed: float = 1.0
@export var reduction_rate: float = 15.0  # La tasa a la que se reduce la distancia por segundo

var player: CharacterBody2D = null
var orbit_distance: float
var orbit_angle: float = 0.0

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	orbit_distance = initial_orbit_distance


func _process(delta: float) -> void:
	if player != null:
		orbit_around_player(delta)
		reduce_orbit_distance(delta)
		rotate_towards_player()

func orbit_around_player(delta: float):
	orbit_angle += orbit_speed * delta
	var offset = Vector2(cos(orbit_angle), sin(orbit_angle)) * orbit_distance
	global_position = player.global_position + offset

func reduce_orbit_distance(delta: float):
	orbit_distance -= reduction_rate * delta
	if orbit_distance < 0:
		orbit_distance = 0  

func rotate_towards_player():
	var direction = (player.global_position - global_position).normalized()
	rotation = direction.angle()

func _on_body_entered(body):
	if body.is_in_group("laser"):
		queue_free()
