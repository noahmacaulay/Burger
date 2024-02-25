extends RigidBody2D

signal clicked

var held = false
@onready var collision_shape_2d = $CollisionShape2D

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	collision_shape_2d.disabled = true
	held = true
	input_pickable = false

func drop(impulse: Vector2, new_position: Vector2=Vector2.ZERO):
	if held:
		freeze = false
		held = false
		collision_shape_2d.disabled = false
		if new_position != Vector2.ZERO:
			position = new_position
		if impulse != Vector2.ZERO:
			apply_central_impulse(impulse)
		input_pickable = true
