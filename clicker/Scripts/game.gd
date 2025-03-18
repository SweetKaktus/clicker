extends Node2D
'''
Ce script me sert à gérer les actions du joueur dans la partie et la progression
'''
# Le compteur de boules de neiges récupérées
var snowballs_collected: int
# Le "pas" de progression de la barre pour générer les boules de neiges en cliquant, 
# augmente au fil des améliorations achetées
var manual_progress_step: int = 1
# Même chose que la var au dessus, mais pour les gains automatiques
var automatic_progress_step: int = 0
# Représente l'intervalle entre cahque tic pour gagner des boules de neiges 
# automatiquement
var automatic_progress_timer: int = 0

# Correspond à l'image de boule de neige au centre de l'écran, c'est un bouton
# comportant une texture.
@onready var snowball: TextureButton = $Control/snowball
# Représente dans l'UI le nb de snowballs collected
@onready var counter: Label = $Control/snowballs_collected/counter
# La barre de progression indiquer une idée du nombre de clics restant avant de
# collecter une snowball
@onready var progress_bar: TextureProgressBar = $Control/snowballs_collected/ProgressBar
# Inventaire des items présents dans la boutique
@onready var v_box_container: VBoxContainer = $Control/ShopPanel/ShopItemsPanel/VBoxContainer

# Taille d'origine de la snowball, réappliquée à chaque fois que la joueuse relâche le clic
var regular_size: Vector2
# Taille de la snowball lorsque la joueuse clic dessus
var pressed_size: Vector2

# Position d'origine de la snowball, réappliquée à chaque fois que la joueuse relâche le clic
var regular_position: Vector2
# Position de la snowball lorsque la joueuse clic dessus
var pressed_position: Vector2


func _ready() -> void:
	# Reset du nb de snowballs collected
	snowballs_collected = 0
	# Reset de la barre de prog
	progress_bar.value = 0
	# Reset du pas appliqué à chaque clic pour collecter les snowballs
	manual_progress_step = 50
	# Reset du pas appliqué pour le gain auto
	automatic_progress_step = 0
	# Reset du tic d'intervalle appliqué pour le gain auto
	automatic_progress_timer = 0
	### Set des varriables de modif de la taille de la snowball au clic ### 
	regular_position = snowball.position
	pressed_position = snowball.position + Vector2(4, 4)
	regular_size = snowball.size
	pressed_size = snowball.size - Vector2(8, 8)
	# Mise à jour du compteur pour aligner la variable logique et celle de l'UI
	update_counter()
	

func _on_texture_button_button_up() -> void:
	# Permet d'initialiser le shop lorsqu'on récupère notre première snowball
	trigger_init_shop()
	# Adapte la taille & la pos de la snowball en fonction du clic
	snowball.size = regular_size
	snowball.position = regular_position
	# Fait augmenter la valeur de la progress barre en fonction du pas
	progress_bar.value += manual_progress_step
	# Met à jour le compteur pour qu'il soit toujours aligné avec le nombre de
	# snowball collected
	update_counter()

func update_counter() -> void:
	# Aligne le nombre de snowballs collected avec le compteur dans l'UI
	counter.text = str(snowballs_collected)
	# Cette boucle me permet d'activer / désactiver l'achat des objets dans le
	# shop au fil de l'évolution du nombre de snowballs collected
	for shop_item in EVENTBUS.shop_items:
		if shop_item.amount_needed > snowballs_collected:
			shop_item.is_active = false
		else:
			shop_item.is_active = true
		EVENTBUS.check_activation.emit(shop_item.item_name, shop_item.is_active)

# La fonction redimensionne l'icône lorsqu'on clic dessus
func _on_texture_button_button_down() -> void:
	snowball.size = pressed_size
	snowball.position = pressed_position

# La fonction permet d'ajouter 1 au snowballs_collected quand on rempli la barre de progression
func _on_progress_bar_value_changed(value: float) -> void:
	if value >= 100:
		progress_bar.value = 0
		snowballs_collected += 1
		update_counter()

# Permet d'initialiser le shop
func trigger_init_shop():
	if not EVENTBUS.is_shop_initialised:
		EVENTBUS.init_shop.emit()
	else:
		pass
