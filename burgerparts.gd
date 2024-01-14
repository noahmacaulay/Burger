extends Control

@onready var request_view = $ColorRect/RequestView

var foods = [
	preload("res://assets/burger-bottom.png"),
	preload("res://assets/cheese.png"),
	preload("res://assets/lettuce.png"),
	preload("res://assets/beef.png"),
	preload("res://assets/tomato.png"),
	preload("res://assets/burger-top.png")
]

var ingredient = preload("res://request_ingredient.tscn")
var celebrate = preload("res://celebrate.tscn")

func _ready():
	randomize()
	new_recipe()

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

func _on_button_pressed():
	new_recipe()
	for node in get_tree().get_nodes_in_group("pickable"):
		node.queue_free()
	add_child(celebrate.instantiate())
