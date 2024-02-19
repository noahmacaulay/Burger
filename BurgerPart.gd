extends RigidBody2D

signal clicked

var held = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	held = true

func drop(impulse):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
