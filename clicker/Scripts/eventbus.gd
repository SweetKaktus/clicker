extends Node

'''
Ce script est accessible par tous les scripts et me permet de gérer des données 
qui sont nécessaires à plusieurs scripts.
'''

# Les items dont je vais me servir, la liste peut être amenée à augmenter ou 
# diminuer en fonction de ce que je souhaite implémenter
var seconde_main : ShopItem
var lutin_exploite : ShopItem
var union_fait_force : ShopItem
var usine : ShopItem


# Stock les icônes (actuellement placeholders) de mes items
var seconde_main_icon = preload("res://Assets/gui/beer-stein.svg")
var lutin_exploite_icon = preload("res://Assets/gui/caveman.svg")
var union_fait_force_icon = preload("res://Assets/gui/waterskin.svg")
var usine_icon = preload("res://Assets/gui/hut.svg")

# Liste stockant l'intégralité des items
var shop_items: Array

# Permet de suivre si le shop a déjà été initialisé ou non
var is_shop_initialised: bool = false

# Signal permettant de trigger la possibilité d'acheter un item ou non
signal check_activation(item_name: String, is_active : bool)
# Signal permettant d'appeler les fonctions d'initialisation du shop à la
# moindre premiere action de la joueuse
signal init_shop

# Est-ce encore utile ? A voir pour supprimer
var icons_for_check_box = {
	"Unchecked" : "res://Assets/gui/Butto.png",
	"Uncheckd_presssed" : "res://Assets/gui/Butto-pressed.png",
	"Checked" : "res://Assets/gui/Buttons-v.png",
	"Checked_pressed" : "res://Assets/gui/Buttons-pressed-v.png"
}


func _ready() -> void:
	# Crées les instances des différents items
	seconde_main = ShopItem.new()
	lutin_exploite = ShopItem.new()
	union_fait_force = ShopItem.new()
	usine = ShopItem.new()
	# initialise les items en leur attribuant un nom, une icône et un 
	# prix d'achat
	seconde_main.initialiser("Seconde main", seconde_main_icon, 2)
	lutin_exploite.initialiser("Lutin exploité", lutin_exploite_icon, 2)
	union_fait_force.initialiser("L'union fait la force", union_fait_force_icon, 5)
	usine.initialiser("Usine", usine_icon, 10)
	# Stocks les items dans la liste "shop_items
	shop_items = [
		seconde_main,
		lutin_exploite,
		union_fait_force,
		usine
	]
