extends Panel

@onready var itemVisual : Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var countLabel : Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	print("updating")
	if !slot.item:
		itemVisual.visible = false
		countLabel.visible = false
	else:
		print(countLabel.text)
		countLabel.text = str(slot.amount)
		print(countLabel.text)
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		if slot.amount > 1:
			countLabel.visible = true
