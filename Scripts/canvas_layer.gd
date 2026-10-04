extends CanvasLayer

@onready var coins_label = $Control/LabelCoins
var total_coins := 0
var collected_coins := 0

func _ready() -> void:
	var coins = get_tree().get_nodes_in_group("coins")
	total_coins=coins.size()
	_update_label_coins()

func _update_label_coins():
	coins_label.text = "%d / %d" %[collected_coins, total_coins]

func coin_collected():
	collected_coins += 1
	_update_label_coins()
