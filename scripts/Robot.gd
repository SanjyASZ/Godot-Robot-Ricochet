extends CharacterBody2D

@export var speed = 700
@export var bg_color = Color(0, 0.7, 0.7, 1)
@export var border_color = Color(1, 0.3, 0.3, 1)
enum COLOR {RED,BLUE,GREEN,YELLOW}
@export var robot_color : COLOR

var cell_size = 50
@onready var panel = $Panel

# VARIABLES
var robot_grid_position = Vector2()
var moving = false
var direction = Vector2.ZERO
var clicked_on_robot = false
var is_robot_colliding = false

# WHEN GAME START
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

# GAME LOOP
func _physics_process(_delta):
	robot_grid_position = Vector2(int(position.x) / 50,	int(position.y) / 50) 
	if not moving and not(Global.red_moving or Global.blue_moving or Global.green_moving or Global.yellow_moving):
		mouse_click()
	if clicked_on_robot:
		wait_robot_to_move()
		if moving:
			move_and_slide()
			stop_robot_to_boundary()
			if is_robot_colliding and Global.moving_collide and Global.static_collide:
				colliding_robot()

# ON MOUSECLICK
func mouse_click():
	if Input.is_action_just_pressed("left_click"):
		var click_position = get_global_mouse_position()
		var grid_mouse_position = Vector2(int(click_position.x) / 50,int(click_position.y) / 50)
		clicked_on_robot = (robot_grid_position == grid_mouse_position)
		if clicked_on_robot:
			give_control()
		else:
			free_control()
	if Input.is_action_just_pressed("right_click"):
		free_control()

# AFTER MOUSECLICK WAITING FOR DIRECTION TO GO
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

# STOP ROBOT TO WALL BOUNDARY
func stop_robot_to_boundary():
	# WALL BOUNDARY
	if position.x < 0: 
		global_position.x = 0
		set_robot_position_after_hitting_wall_()
	if position.y < 0: 
		global_position.y = 0
		set_robot_position_after_hitting_wall_()
	if position.x > 750: 
		global_position.x = 750
		set_robot_position_after_hitting_wall_()
	if position.y > 750: 
		global_position.y = 750
		set_robot_position_after_hitting_wall_()

# REPLACE ROBOT POSITION AFTER HITTING WALL
func set_robot_position_after_hitting_wall_():
	velocity = Vector2.ZERO
	robot_grid_position.x = int(ceil(position.x/10)*10) / 50
	robot_grid_position.y = int(ceil(position.y/10)*10) /50
	print("position :", position)
	global_position.x = robot_grid_position.x * 50
	global_position.y = robot_grid_position.y * 50
	set_global_moving_false()

# GIVE CONTROL OF THE ROBOT THE PLAYER CLICKED ON
func give_control():
	var stylebox_flat = StyleBoxFlat.new()
	stylebox_flat.set_border_width_all(5)
	stylebox_flat.set_corner_radius_all(40)
	stylebox_flat.border_color = border_color
	stylebox_flat.bg_color = bg_color
	panel.add_theme_stylebox_override("panel",stylebox_flat)

# FREE THE CONTROL OF THE ROBOT
func free_control():
	clicked_on_robot = false
	var stylebox_flat = StyleBoxFlat.new()
	stylebox_flat.set_border_width_all(0)
	stylebox_flat.set_corner_radius_all(40)
	stylebox_flat.bg_color = bg_color
	panel.add_theme_stylebox_override("panel",stylebox_flat)

# WHEN A ROBOT IS MOVING EVERY OTHER ROBOT SHOULD BE STATIC
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

# RELEASE ALL ROBOT TO PERMIT PLAYER TO CLICK AGAIN
func set_global_moving_false():
	moving = false
	Global.red_moving = false
	Global.blue_moving = false
	Global.green_moving = false
	Global.yellow_moving = false

# WHEN TWO ROBOTS COLLIDES
func colliding_robot():
	Global.moving_collide = false
	Global.static_collide = false
	var collide = false
	if moving and Global.moving_robot_position.y > Global.static_robot_position.y:
		robot_grid_position.y = (int(Global.static_robot_position.y) / 50) + 1
		collide = true
	if not collide and moving and Global.moving_robot_position.y < Global.static_robot_position.y:
		robot_grid_position.y = (int(Global.static_robot_position.y) / 50) - 1
		collide = true
	if not collide and moving and Global.moving_robot_position.x > Global.static_robot_position.x:
		robot_grid_position.x = (int(Global.static_robot_position.x) / 50) + 1
		collide = true
	if not collide and moving and Global.moving_robot_position.x < Global.static_robot_position.x:
		robot_grid_position.x = (int(Global.static_robot_position.x) / 50) - 1
		collide = true
	global_position.x = robot_grid_position.x * 50
	global_position.y = robot_grid_position.y * 50
	is_robot_colliding = false
	set_global_moving_false()

# DETECT COLLISIONS WALLS OR ROBOTS
func _on_area_2d_area_entered(area):
	if area.is_in_group("robots"):
		velocity = Vector2.ZERO
		# Get position of moving and static robot
		if moving:
			Global.moving_robot_position = position
			Global.moving_collide = true
		else:
			Global.static_robot_position = position
			Global.static_collide = true
		is_robot_colliding = true
	if area.is_in_group("walls"):
		set_robot_position_after_hitting_wall_()
		
