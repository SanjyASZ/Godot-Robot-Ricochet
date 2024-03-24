extends CharacterBody2D

const speed = 300
var current_dir = "down"

func _physics_process(_delta):
	if not PlayerMovement.stop_movement:
		player_movement(_delta) 

func player_movement(_delta):
	if Input.is_action_pressed("right"):
		play_anim(1)
		current_dir = "right"
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		play_anim(1)
		current_dir = "left"
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("down"):
		play_anim(1)
		current_dir = "down"
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("up"):
		play_anim(1)
		current_dir = "up"
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		var push_force=200
		if c.get_collider() is RigidBody2D:
			print("Collider", c.get_collider().get_groups())
			if c.get_collider().is_in_group("Blue_Planet"):
				PlayerMovement.stop_movement = true
				play_anim(0)
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func play_anim(movement):
	var anim = $AnimatedSprite2D
	
	if current_dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	
	if current_dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
		
	if current_dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	
	if current_dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
