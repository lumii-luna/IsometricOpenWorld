extends Control

@export var inventory : inv
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

var is_open : bool = false

func _ready():
	if inventory:
		inventory.updateInventory.connect(update_slots)
		update_slots()
	else:
		print("Error: Inventory Resource is missing from the Inspector")
	close()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggleInventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
