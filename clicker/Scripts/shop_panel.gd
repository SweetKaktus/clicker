extends Panel

'''
Ce script me permet de gérer le shop
'''

# Position du shop lorsqu'il n'est pas activé
var hidden_position: Vector2
# Position du shop lorsqu'il est activé
var displayed_position: Vector2

# Variable qui suit si le shop est activé ou non
var is_shop_active: bool


# Référence au bouton d'activation du shop
@onready var shop_button: TextureButton = $shop_button
# Référence "L'inventaire" de la boutique qui vient stocker les items de la boutique
@onready var v_box_container: VBoxContainer = $ShopItemsPanel/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Permet de faire savoir qu'il faudra init le shop à la moindre première action
	EVENTBUS.is_shop_initialised = false
	# Permet de trigger la func init_shop() lorsque le signal EVENTBUS.init_shop est triggered
	EVENTBUS.init_shop.connect(init_shop)
	# Enregistre la position par défaut (cachée) du shop
	hidden_position = position
	# Définit la position du shop une fois ouvert
	displayed_position = position - Vector2(0, 350)
	# Désactive le shop par défaut au lancement
	is_shop_active = false
	
	
	
	

# Définit les actions à effectuer lorsqu'on clic sur le bouton "shop"
func _on_shop_button_pressed() -> void:
	# Initialise le shop (check si actif ou non dans la fonction init_shop)
	init_shop()
	
	# Suite d'action pour active le shop
	if not is_shop_active:
		is_shop_active = true
		# Créer un tween pour gérer l'animation de glissement du shop du bas vers le haut
		var tween = create_tween()
		tween.tween_property(self, "position", displayed_position, 0.35)
		# Tues le tween pour le libérer de la mémoire lorsque l'anim est terminée
		tween.tween_callback(tween.kill)
	else:
		# Même procédés que les éléments décris juste au dessus
		is_shop_active = false
		var tween = create_tween()
		tween.tween_property(self, "position", hidden_position, 0.35)
		tween.tween_callback(tween.kill)

# Permet d'ajouter les éléments au shop
func add_element_to_shop(item_name: String, texture: Texture2D, amount_needed: int, amount_bought: int = 0, is_active: bool = false):
	# Récupère dans une var temp les données de la scene "shop_element"
	var shop_element = load("res://Scenes/shop_element.tscn")
	# Instancie un objet "shop_element"
	var shop_element_instance = shop_element.instantiate()
	# Ajoute l'instance de l'objet à mon inventaire de shop
	v_box_container.add_child(shop_element_instance)
	# Définit le nom de l'item
	shop_element_instance.update_item_name(item_name)
	# Définit le l'icone de l'item
	shop_element_instance.update_icon(texture)
	# Désactive l'item par défaut
	shop_element_instance.update_activation(item_name, is_active)
	# Définit le nombre de boules de neige nécessaires pour acheter l'item
	shop_element_instance.update_amount_needed(amount_needed)
	# Met à jour le nombre d'occurrences de l'item détenu (par défaut : 0)
	shop_element_instance.update_amount_bought(amount_bought)

func init_shop():
	# Permet d'initialiser le shop s'il ne l'est pas déjà
	if not EVENTBUS.is_shop_initialised:
		EVENTBUS.is_shop_initialised = true
		# Boucle sur les éléments de la liste EVENTBUS.shop_items pour ajouter chaque élément au shop
		for element in EVENTBUS.shop_items:
			# Récupères les valeurs détenues par les items pour mettre à jour les éléments du shop dans l'UI
			add_element_to_shop(element.item_name, 
								element.icon, 
								element.is_active,
								element.amount_needed, 
								element.amount_bought)
	else:
		pass
