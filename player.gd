extends KinematicBody2D

var velocity = Vector2(0,0)
var coins = 0
const SPEED = 180
const JUMPFORCE = -1000
const GRAVITY = 35

func _physics_process(delta):
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("Walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("Walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("Idle")
		
	if not is_on_floor():
		$Sprite.play("Air")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMPFORCE
		$SoundJump.play()
		
	velocity = move_and_slide(velocity,Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.4)
	
	

func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://Control.tscn")


func bounce():
	velocity.y = JUMPFORCE * 0.5
	
	
func ouch(var enemyposx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.3
	
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
		
		
	Input.action_release("left")
	Input.action_release("right")
	$Timer.start()
	
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Control.tscn")
