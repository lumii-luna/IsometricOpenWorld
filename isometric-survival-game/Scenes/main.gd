extends Node2D

@onready var seed_scene = preload("res://2DInventory/items/seed_item.tscn")
var seeds : Array[Node] = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawnSeed"):
		spawn_seed()

func spawn_seed():
	var seed = seed_scene.instantiate()
	print(seed.position)
	seeds.append(seed)
	seed.seed_number = seeds.size()
	add_child(seed)

func destroy_seed(index):
	if 0 <= index < seeds.size():
		seeds[index].queue_free()
		seeds.remove_at(index)
