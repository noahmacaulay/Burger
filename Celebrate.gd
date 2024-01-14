extends Control

var possibilities = [
	"WOW!",
	"HUH?",
	"OOPS!",
	"OK...",
	"BURGER?!"
]

@onready var text = $RichTextLabel
@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer

func _ready():
	text.text = possibilities[randi() % 5]
	timer.start(3)
	animation_player.play("fadeout")

func _on_timer_timeout():
	queue_free()
