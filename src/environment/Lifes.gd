extends Node2D

# Called when the node enters the scene tree for the first time.

func _ready():
	$ani_spr_life.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _play_existir():
	$ani_spr_life.play("existir")

func _play_lose_life():
	$ani_spr_life.play("lose_life")
	_on_animation_finished()

func _on_animation_finished():
	self.visible = false
