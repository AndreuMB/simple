extends CanvasLayer

@onready var coins_label = $Control/LabelCoins
var total_coins := 0
var collected_coins := 0

@onready var timer_label = $Control/LabelTimer
@export var start_time:float = 10
var left_time:float = 10

func _ready() -> void:
	var coins = get_tree().get_nodes_in_group("coins")
	total_coins=coins.size()
	_update_label_coins()
	left_time = start_time
	
func _process(delta: float) -> void:
	if left_time > 0:
		left_time -= delta
		left_time = max(left_time,0)
		timer_label.text = "%.2f" % left_time
		return
	get_tree().reload_current_scene()

func _update_label_coins():
	coins_label.text = "%d / %d" %[collected_coins, total_coins]

func load_next_level():
	var current_scene = get_tree().current_scene
	var current_scene_name = current_scene.scene_file_path
	var level_number = int(current_scene_name.get_basename().replace("level_",""))
	var next_level = level_number + 1
	
	var new_scene_path = "res://Scenes/level_%d.tscn" % next_level
	get_tree().change_scene_to_file(new_scene_path)

func coin_collected():
	collected_coins += 1
	_update_label_coins()
	if (collected_coins == total_coins):
		load_next_level()
