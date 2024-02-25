extends AnimatedSprite2D

signal lid_anim_finished
@onready var animation_player : AnimationPlayer = %AnimationPlayer

func _ready():
	connect("animation_finished", exit_screen)

func exit_screen():
	disconnect("animation_finished", exit_screen)
	animation_player.play('exit_screen')

func enter_screen():
	animation_player.play("enter_screen")

func open_lid():
	play_backwards("default")
	connect("animation_finished", finish_opening)

func finish_opening():
	disconnect("animation_finished", finish_opening)
	connect("animation_finished", exit_screen)
	frame = 0
	emit_signal("lid_anim_finished")
