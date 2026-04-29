extends Resource

class_name inv

@export var slots: Array[InvSlot]
var duplicate: bool = false

signal updateInventory

func insert(item: InvItem):
	print("inserting")
	duplicate = false
	for i in slots:
		if i.item == item:
			print(i)
			i.amount += 1
			duplicate = true
			updateInventory.emit()
		else:
			print(i)
	if !duplicate:
		for i in slots:
			if i == null:
				print(i)
				slots[i].item = item
				updateInventory.emit()
			else:
				print(i)
