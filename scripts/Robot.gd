extends CharacterBody2D

@export var speed = 700
@export var bg_color = Color(0, 0.7, 0.7, 1)
@export var border_color = Color(1, 0.3, 0.3, 1)
enum COLOR {RED,BLUE,GREEN,YELLOW}
@export var robot_color : COLOR

var cell_size = 50
@onready var panel = $Panel

var robot_grid_position = Vector2()
var moving = false
var direction = Vector2.ZERO
var clicked_on_robot = false

func _ready():
	# ATTRIBUTE COLOR ROBOT
	if robot_color == COLOR.RED:
		bg_color = Color(0.8, 0.2, 0.2, 1)
		border_color = Color(0.2, 0.8, 0.8, 1)
	elif robot_color == COLOR.BLUE:
		bg_color = Color(0.2, 0.2, 0.8, 1)
		border_color = Color(0.8, 0.8, 0.2, 1) 
	elif robot_color == COLOR.GREEN:
		bg_color = Color(0.2, 0.8, 0.2, 1)
		border_color = Color(0.8, 0.2, 0.8, 1)
	elif robot_color == COLOR.YELLOW:
		bg_color = Color(0.8, 0.8, 0.2, 1)
		border_color = Color(0.2, 0.2, 0.8, 1) 
	robot_grid_position = Vector2(int(position.x) / 50,	int(position.y) / 50)
		
func _physics_process(delta):
	if not moving and not(Global.red_moving or Global.blue_moving or Global.green_moving or Global.yellow_moving):
		mouse_click()
	if clicked_on_robot:
		wait_robot_to_move()
		move_and_slide()
	stop_robot_to_wall()

func wait_robot_to_move():
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
			set_global_moving()
				
	else:
		velocity = direction * speed
		
func set_robot_position():
	velocity = Vector2.ZERO
	robot_grid_position.x = int(position.x) / 50
	robot_grid_position.y = int(position.y) / 50
	global_position.x = robot_grid_position.x * 50
	global_position.y = robot_grid_position.y * 50
	set_global_moving_false()

func stop_robot_to_wall():
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
		var click_position = get_global_mouse_position()
		var grid_mouse_position = Vector2(int(click_position.x) / 50,int(click_position.y) / 50)
		robot_grid_position = Vector2(int(position.x) / 50,	int(position.y) / 50)
		clicked_on_robot = (robot_grid_position == grid_mouse_position)
		if clicked_on_robot:
			give_control()
		else:
			free_control()
	if Input.is_action_just_pressed("right_click"):
		free_control()
		
func give_control():
	var stylebox_flat = StyleBoxFlat.new()
	stylebox_flat.set_border_width_all(5)
	stylebox_flat.set_corner_radius_all(40)
	stylebox_flat.border_color = border_color
	stylebox_flat.bg_color = bg_color
	panel.add_theme_stylebox_override("panel",stylebox_flat)

func free_control():
	clicked_on_robot = false
	var stylebox_flat = StyleBoxFlat.new()
	stylebox_flat.set_border_width_all(0)
	stylebox_flat.set_corner_radius_all(40)
	stylebox_flat.bg_color = bg_color
	panel.add_theme_stylebox_override("panel",stylebox_flat)

func set_global_moving():
	if robot_color == COLOR.RED:
		Global.red_moving = true
		Global.blue_moving = false
		Global.green_moving = false
		Global.yellow_moving = false
		moving = Global.red_moving
	elif robot_color == COLOR.GREEN:
		Global.red_moving = false
		Global.blue_moving = false
		Global.green_moving = true
		Global.yellow_moving = false
		moving = Global.green_moving
	elif robot_color == COLOR.BLUE:
		Global.red_moving = false
		Global.blue_moving = true
		Global.green_moving = false
		Global.yellow_moving = false
		moving = Global.blue_moving
	elif robot_color == COLOR.YELLOW:
		Global.red_moving = false
		Global.blue_moving = false
		Global.green_moving = false
		Global.yellow_moving = true
		moving = Global.yellow_moving

func set_global_moving_false():
	moving = false
	Global.red_moving = false
	Global.blue_moving = false
	Global.green_moving = false
	Global.yellow_moving = false

func _on_area_2d_area_entered(area):
	set_robot_position()
