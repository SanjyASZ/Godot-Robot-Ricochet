class_name TreeNode

var color : String
var move : String
var explored = false
var solution = ""
var children = []

func _init(_color,_move):
	color = _color
	move = _move

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
	
func recursive_bfs(node: TreeNode):
	if node.color != "0":
		node.solution = node.solution + node.color + node.move
	if node.children.size() == 0:
		return
	else:
		for child in node.children:
			child.solution = node.solution + node.color + node.move
			recursive_bfs(child)
	
func parcours(start_node: TreeNode):
	var queue = []
	queue.push_back(start_node)
	
	while queue.size() > 0:
		var current = queue.pop_front()
		if current.solution.length() > 10:
			print("Solution : ", current.solution)
		
		for child in current.children:
			queue.push_back(child)

