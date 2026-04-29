extends Panel

signal slot_clicked(index: int)

@onready var itemVisual : Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var countLabel : Label = $CenterContainer/Panel/Label

var slotIndex : int = -1

func update(slot: InvSlot):
	if !slot.item:
		itemVisual.visible = false
		countLabel.visible = false
	else:
		countLabel.text = str(slot.amount)
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		if slot.amount > 1:
			countLabel.visible = true


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			slot_clicked.emit(slotIndex)
