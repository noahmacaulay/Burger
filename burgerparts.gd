extends Control

@export var default_part_spawn : Vector2 = Vector2(200.0, 300.0)

@onready var takeout = %Takeout
@onready var request_view = %RequestView
var held_object = null

var burgerpart = preload("res://BurgerPart.tscn")
var celebrate = preload("res://celebrate.tscn")
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
	takeout.connect("lid_anim_finished", self._on_lid_anim_finished)
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
		if held_object and event.is_action_released("release"):
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

func _on_button_pressed():
	for node in ingredient_group.get_children():
		ingredient_group.remove_child(node)
		node.queue_free()
	takeout.play("default")
	add_child(celebrate.instantiate())

func _on_lid_anim_finished():
	new_recipe()

func _on_part_button_down(sprite_index : int):
	var new_part = burgerpart.instantiate()
	new_part.get_node("sprite").texture = foods[sprite_index]
	new_part.add_to_group("pickable")
	new_part.clicked.connect(_on_pickable_clicked)
	$IngredientGroup.add_child(new_part)
	if (held_object):
		new_part.position = default_part_spawn
		return
	new_part.position = get_viewport().get_mouse_position()
	_on_pickable_clicked(new_part)

func _on_part_button_up():
	if (held_object):
		held_object.position = default_part_spawn
		held_object.drop(Vector2.ZERO)
		held_object = null
