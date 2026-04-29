extends Resource

class_name inv

@export var slots: Array[InvSlot]
var duplicate: bool = false

signal updateInventory

func insert(item: InvItem):
	for slot in slots:
		if slot.item == item:
			slot.amount += 1
			updateInventory.emit()
			return
	
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.amount = 1
			updateInventory.emit()
			return
