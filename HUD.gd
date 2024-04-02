extends CanvasLayer

var coins = 0

func _ready():
	$coinnum.text = String(coins)


	
func _on_coin_collected():
	coins += 1
	_ready()
	if coins == 14:
		get_tree().change_scene("res://You Win.tscn")
