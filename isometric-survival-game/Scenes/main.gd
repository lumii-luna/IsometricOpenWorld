extends Node2D

@onready var seed_scene = preload("res://2DInventory/items/seed_item.tscn")
@onready var player = $Player
var seeds : Array[Node] = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggleSeed"):
		if seeds == []:
			spawn_seed()
		else:
			destroy_seed(seeds.size()-1)

func spawn_seed():
	var seed = seed_scene.instantiate()
	seed.position = Vector2(player.position.x + 32, player.position.y)
	seeds.append(seed)
	seed.seed_number = seeds.size()
	add_child(seed)

func destroy_seed(index):
	seeds[index].queue_free()
	seeds.remove_at(index)
