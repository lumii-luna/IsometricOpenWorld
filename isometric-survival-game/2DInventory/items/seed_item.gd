extends Area2D

@export var item: InvItem
var player = null
var seed_number: int = 0

signal collected(index)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player.collect(item)
		collected.emit(seed_number)
		print("collected")
