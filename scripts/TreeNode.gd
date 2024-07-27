class_name TreeNode

var solution = ""
var children = []

func _init(_solution: String = ""):
	self.solution = _solution

func add_node_child(child: TreeNode):
	children.append(child)
