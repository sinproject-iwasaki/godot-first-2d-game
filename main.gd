extends Node

const mob_scene = preload("res://mob.tscn")

const Hud = preload("res://HUD.gd")
const Player = preload("res://player.gd")
const Mob = preload("res://mob.gd")

@onready var mob_timer: Timer = $MobTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var start_timer: Timer = $StartTimer
@onready var hud: Hud = $HUD
@onready var player: Player = $Player
@onready var start_position: Marker2D = $StartPosition
@onready var music: AudioStreamPlayer = $Music
@onready var death_sound: AudioStreamPlayer = $DeathSound

var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mob_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func game_over() -> void:
	score_timer.stop()
	#mob_timer.stop()
	hud.show_game_over()

	music.stop()
	death_sound.play()


func new_game() -> void:
	mob_timer.stop()
	get_tree().call_group("mods", "queue_free")

	score = 0
	player.start(start_position.position)
	start_timer.start()

	hud.update_score(score)
	hud.show_message("Get Ready")
	music.play()


func _on_score_timer_timeout() -> void:
	score += 1
	hud.update_score(score)


func _on_start_timer_timeout() -> void:
	mob_timer.start()
	score_timer.start()


func _on_mob_timer_timeout() -> void:
	var mob: Mob = mob_scene.instantiate()

	var mob_spawn_location: PathFollow2D = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	var direction: float = mob_spawn_location.rotation + PI / 2

	mob.position = mob_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity := Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)
