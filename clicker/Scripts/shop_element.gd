extends HBoxContainer

'''
Ce script me permet de gérer les éléments du shop
'''
# Références aux différents élements composant ma scene
@onready var purchase_btn: Button = $PurchaseBTN
@onready var item_name_lb: Label = $ItemNameLB
@onready var icon_tr: TextureRect = $IconTR
@onready var amount_needed_lb: Label = $AmountNeededLB
@onready var amount_bought_lb: Label = $AmountBoughtLB

# Références aux icônes du bouton (une icône lorsqu'il est "pressé" et une lorsqu'il est "standard"
@onready var icon_pressed_purchase_button : Texture2D = preload("res://Assets/gui/Buttons-pressed-shoping-cart.png")
@onready var icon_purchase_button : Texture2D = preload("res://Assets/gui/Buttons-shoping-cart.png")

# Liste permettant de récupérer la liste d'items stockés dans le script EVENTBUS
var shop_items : Array

func _ready() -> void:
	# Récupère les items stockés dans le script EVENTBUS pour les inscrire dans la var de ce script
	shop_items = EVENTBUS.shop_items
	# Trigger la func update_activation() lorsque le signal check_activation est émit du script EVENTBUS
	EVENTBUS.check_activation.connect(update_activation)

# Mets à jour dans l'UI le nom de l'item
func update_item_name(item_name: String):
	item_name_lb.text = item_name

# Mets à jour dans l'UI l'icone de l'item
func update_icon(icon: Texture2D):
	icon_tr.texture = icon

# Mets à jour dans l'UI le nombre de snowballs nécessaires pour l'achat de l'item
func update_amount_needed(amount_needed: int):
	amount_needed_lb.text = str(amount_needed)
	
# Mets à jour dans l'UI le nombre d'occurrences de l'item détenues
func update_amount_bought(amount_bought: int):
	amount_needed_lb.text = str(amount_bought)

# Permet de griser / dégriser le bouton d'achat en fonction du nom de l'item
func update_activation(item_name: String, is_active: bool):
	if item_name_lb.text == item_name:
		purchase_btn.disabled = !is_active
	if item_name_lb.text == "Seconde main":
		print(item_name_lb.text + " activation " + str(is_active))
		print("Option désactiver : " + str(purchase_btn.disabled))

# Permet de changer l'icone du bouton d'achat (pour gérer "pressé" / "relaché"
func update_icon_btn(icon: Texture2D) -> void:
	purchase_btn.icon = icon


# Affiche l'icône d'achat "pressé" lorsque le bouton est pressé
func _on_purchase_button_button_down() -> void:
	update_icon_btn(icon_pressed_purchase_button)

# Affiche l'icône d'achat "relaché" lorsque le bouton est relaché
func _on_purchase_button_button_up() -> void:
	update_icon_btn(icon_purchase_button)
