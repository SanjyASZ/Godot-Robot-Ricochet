class_name TreeNode

var color : String
var move : String
var explored = false
var solution = ""
var children = []

func _init(_color,_move,_solution: String = ""):
	color = _color
	move = _move
	self.solution = _solution

func add_node_child(child: TreeNode):
	children.append(child)

func add_4_robot_4_move(tree: TreeNode):
	# RED
	tree.children.append(TreeNode.new("R","U"))
	tree.children.append(TreeNode.new("R","R"))
	tree.children.append(TreeNode.new("R","D"))
	tree.children.append(TreeNode.new("R","L"))
	# GREEN
	tree.children.append(TreeNode.new("G","U"))
	tree.children.append(TreeNode.new("G","R"))
	tree.children.append(TreeNode.new("G","D"))
	tree.children.append(TreeNode.new("G","L"))
	# BLUE
	tree.children.append(TreeNode.new("B","U"))
	tree.children.append(TreeNode.new("B","R"))
	tree.children.append(TreeNode.new("B","D"))
	tree.children.append(TreeNode.new("B","L"))
	# YELLOW
	tree.children.append(TreeNode.new("Y","U"))
	tree.children.append(TreeNode.new("Y","R"))
	tree.children.append(TreeNode.new("Y","D"))
	tree.children.append(TreeNode.new("Y","L"))
	

func parcours(start_node: TreeNode):
	var queue = []
	queue.push_back(start_node)
	print("PASSE") # LAS
	while queue.size() > 0:
		var current = queue.pop_front()
		print("node:", current.color, current.move) # LAS
		for child in current.children:
			queue.push_back(child)
