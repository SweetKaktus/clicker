extends HBoxContainer

@onready var purchase_btn: Button = $PurchaseBTN
@onready var item_name_lb: Label = $ItemNameLB
@onready var icon_tr: TextureRect = $IconTR
@onready var amount_needed_lb: Label = $AmountNeededLB
@onready var amount_bought_lb: Label = $AmountBoughtLB

@onready var icon_pressed_purchase_button : Texture2D = preload("res://Assets/gui/Buttons-pressed-shoping-cart.png")
@onready var icon_purchase_button : Texture2D = preload("res://Assets/gui/Buttons-shoping-cart.png")

var shop_items : Array

func _ready() -> void:
	shop_items = EVENTBUS.shop_items
	EVENTBUS.check_activation.connect(update_activation)

func update_item_name(item_name: String):
	item_name_lb.text = item_name

func update_icon(icon: Texture2D):
	icon_tr.texture = icon

func update_amount_needed(amount_needed: int):
	amount_needed_lb.text = str(amount_needed)
	
func update_amount_bought(amount_bought: int):
	amount_needed_lb.text = str(amount_bought)
	
func update_activation(item_name: String, is_active: bool):
	if item_name_lb.text == item_name:
		purchase_btn.disabled = !is_active
	if item_name_lb.text == "Seconde main":
		print(item_name_lb.text + " activation " + str(is_active))
		print("Option désactiver : " + str(purchase_btn.disabled))

func update_icon_btn(icon: Texture2D) -> void:
	purchase_btn.icon = icon


func _on_purchase_button_button_down() -> void:
	update_icon_btn(icon_pressed_purchase_button)


func _on_purchase_button_button_up() -> void:
	update_icon_btn(icon_purchase_button)
