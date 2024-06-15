extends Node

# Boolean indication moving robots
var red_moving = false
var blue_moving = false
var green_moving = false
var yellow_moving = false

# Position indication of moving robots colliding with static Robots
var static_robot_position = Vector2.ZERO
var moving_robot_position = Vector2.ZERO

# Boolean to know when collision is done
var moving_collide = false
var static_collide= false
