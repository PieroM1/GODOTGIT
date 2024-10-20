extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$planeta1.play("existir")
	$planeta2.play("existir")
	$planeta3.play("existir")
	$planeta4.play("existir")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
