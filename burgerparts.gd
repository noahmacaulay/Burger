extends Control

@onready var request_view = $ColorRect/RequestView
var held_object = null

var burgerpart = preload("res://BurgerPart.tscn")
@onready var ingredient_group = $IngredientGroup

func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object
		
var foods = [
	preload("res://assets/burger-bottom.png"),
	preload("res://assets/cheese.png"),
	preload("res://assets/lettuce.png"),
	preload("res://assets/beef.png"),
	preload("res://assets/tomato.png"),
	preload("res://assets/burger-top.png")
]

var ingredient = preload("res://request_ingredient.tscn")

func _ready():
	randomize()
	new_recipe()
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_clicked)

func new_recipe():
	for n in request_view.get_children():
		request_view.remove_child(n)
		n.queue_free()
	add_ingredient(0)
	var randoms = range(1,4)
	randoms.shuffle()
	for i in range(randi() % 3):
		randoms.pop_back()
	for i in randoms:
		add_ingredient(i)
	add_ingredient(5)

func add_ingredient(n):
	var i : TextureRect = ingredient.instantiate()
	request_view.add_child(i)
	i.texture = foods[n]

func _on_timer_timeout():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

func _on_button_pressed():
	new_recipe()


func _on_button_2_pressed():
	var bottom_bun = burgerpart.instantiate()
	bottom_bun.position = Vector2(200.0, 300.0)
	bottom_bun.get_node("sprite").texture = foods[0]
	$IngredientGroup.add_child(bottom_bun)


func _on_cheese_button_pressed():
	var bottom_bun = burgerpart.instantiate()
	bottom_bun.position = Vector2(200.0, 300.0)
	bottom_bun.get_node("sprite").texture = foods[1]
	$IngredientGroup.add_child(bottom_bun)


func _on_lettuce_button_pressed():
	var bottom_bun = burgerpart.instantiate()
	bottom_bun.position = Vector2(200.0, 300.0)
	bottom_bun.get_node("sprite").texture = foods[2]
	$IngredientGroup.add_child(bottom_bun)


func _on_top_button_pressed():
	var bottom_bun = burgerpart.instantiate()
	bottom_bun.position = Vector2(200.0, 300.0)
	bottom_bun.get_node("sprite").texture = foods[5]
	$IngredientGroup.add_child(bottom_bun)


func _on_burger_button_pressed():
	var bottom_bun = burgerpart.instantiate()
	bottom_bun.position = Vector2(200.0, 300.0)
	bottom_bun.get_node("sprite").texture = foods[3]
	$IngredientGroup.add_child(bottom_bun)


func _on_tomato_button_pressed():
	var bottom_bun = burgerpart.instantiate()
	bottom_bun.position = Vector2(200.0, 300.0)
	bottom_bun.get_node("sprite").texture = foods[4]
	$IngredientGroup.add_child(bottom_bun)
