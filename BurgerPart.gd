extends RigidBody2D

signal clicked

var held = false
@onready var collision_shape_2d = $CollisionShape2D

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	collision_shape_2d.disabled = true
	held = true
	input_pickable = false

func drop(impulse):
	if held:
		freeze = false
		collision_shape_2d.disabled = false
		apply_central_impulse(impulse)
		held = false
		input_pickable = true
