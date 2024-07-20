extends Node

# Boolean indication moving robots
var red_moving = false
var blue_moving = false
var green_moving = false
var yellow_moving = false

# Vector indication position robots
var red_position = Vector2.ZERO
var blue_position = Vector2.ZERO
var green_position = Vector2.ZERO
var yellow_position = Vector2.ZERO

# Position indication of moving robots colliding with static Robots
var static_robot_position = Vector2.ZERO
var moving_robot_position = Vector2.ZERO

# Boolean to know when collision is done
var moving_collide = false
var static_collide= false

# Target Position
var target_position = Vector2(12,13)

# Structure to store all combination and find the solution
var noeud_rac = TreeNode.new("0","0")

# Solution
var solution: String
var solution_found: bool
