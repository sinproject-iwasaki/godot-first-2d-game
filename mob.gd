extends RigidBody2D

@onready var animation_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mod_types = animation_sprite_2d.sprite_frames.get_animation_names()
	animation_sprite_2d.play(mod_types[randi() % mod_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
