extends CharacterBody2D


@export var speed = 700
@export var cell_size = 50

var robot_grid_position = Vector2()
var moving = false
var direction = Vector2.ZERO
var click_position = Vector2()

func _ready():
	robot_grid_position.x = int(position.x) / 50
	robot_grid_position.x = int(position.y) / 50
	
func _physics_process(delta):
	if not moving:
		direction = Vector2.ZERO
		if Input.is_action_just_pressed('right'):
			direction = Vector2.RIGHT
		elif Input.is_action_just_pressed('left'):
			direction = Vector2.LEFT
		elif Input.is_action_just_pressed('down'):
			direction = Vector2.DOWN
		elif Input.is_action_just_pressed('up'):
			direction = Vector2.UP
			
		if direction != Vector2.ZERO:
			moving = true
	else:
		velocity = direction * speed
	hit_obstacle(position)
	mouse_click()
	move_and_slide()

func set_robot_position():
	velocity = Vector2.ZERO
	robot_grid_position.x = int(position.x) / 50
	robot_grid_position.y = int(position.y) / 50
	moving = false

func hit_obstacle(position):
	# WALL BOUNDARY
	if position.x < 0: 
		global_position.x = 0
		set_robot_position()
	if position.y < 0: 
		global_position.y = 0
		set_robot_position()
	if position.x > 750: 
		global_position.x = 750
		set_robot_position()
	if position.y > 750: 
		global_position.y = 750
		set_robot_position()

func mouse_click():
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		var grid_mouse_position = Vector2()
		grid_mouse_position.x = int(click_position.x) / 50
		grid_mouse_position.y = int(click_position.y) / 50
		print("robot:", robot_grid_position, "mouse:", grid_mouse_position)
