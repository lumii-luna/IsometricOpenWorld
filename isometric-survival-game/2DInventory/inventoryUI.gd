extends Control

@export var inventory : inv
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
@onready var heldVisual : TextureRect = $HeldItemVisual

var held_slot : InvSlot = null
var is_open : bool = false

func _ready():
	if inventory:
		inventory.updateInventory.connect(update_slots)
		for i in range(slots.size()):
			slots[i].slotIndex = i
			slots[i].slot_clicked.connect(_on_slot_clicked)
		update_slots()
	close()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func _process(delta: float):
	if held_slot and held_slot.item:
		heldVisual.visible = true
		heldVisual.texture = held_slot.item.texture
		var offset = heldVisual.size * 1.2
		heldVisual.global_position = get_global_mouse_position() - offset
	else:
		heldVisual.visible = false

	if Input.is_action_just_pressed("toggleInventory"):
		if is_open:
			close()
		else:
			open()
	
func _on_slot_clicked(index: int):
	var clicked_inv_slot = inventory.slots[index]

	if held_slot == null:
		if clicked_inv_slot.item != null:
			held_slot = clicked_inv_slot.duplicate()
			clicked_inv_slot.item = null
			clicked_inv_slot.amount = 0
	else:
		if clicked_inv_slot.item != held_slot.item:
			var temp_item = clicked_inv_slot.item
			var temp_amount = clicked_inv_slot.amount
			
			clicked_inv_slot.item = held_slot.item
			clicked_inv_slot.amount = held_slot.amount
			
			if temp_item != null:
				held_slot.item = temp_item
				held_slot.amount = temp_amount
			else:
				held_slot = null # Hand is now empty

		else:
			clicked_inv_slot.amount += held_slot.amount
			held_slot = null

	inventory.updateInventory.emit()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
