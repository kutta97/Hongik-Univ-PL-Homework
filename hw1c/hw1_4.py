class Node:
	def __init__(self, data):
		self.data = data
		self.left = None
		self.right = None

class BinaryTree():
	def __init__(self):
		self.root = None

	def preorder_traverse(self):
		print("Preorder Traverse")
		self._preorder_traverse(self.root)

	def _preorder_traverse(self, node):
		if node is None: return
		print(node.data)
		self._preorder_traverse(node.left)
		self._preorder_traverse(node.right)

	def inorder_traverse(self):
		print("Inorder Traverse")
		self._inorder_traverse(self.root)

	def _inorder_traverse(self, node):
		if node is None: return
		self._inorder_traverse(node.left)
		print(node.data)
		self._inorder_traverse(node.right)

	def postorder_traverse(self):
		print("Postorder Traverse")
		self._postorder_traverse(self.root)

	def _postorder_traverse(self, node):
		if node is None: return
		self._postorder_traverse(node.left)
		self._postorder_traverse(node.right)
		print(node.data)

binaryTree = BinaryTree()

# root
binaryTree.root = Node(15)

# level-order: 1
binaryTree.root.left = Node(1)
binaryTree.root.right = Node(37)

# level-order: 2
binaryTree.root.left.left = Node(61)
binaryTree.root.left.right = Node(26)
binaryTree.root.right.left = Node(59)
binaryTree.root.right.right = Node(48)

binaryTree.preorder_traverse()
binaryTree.inorder_traverse()
binaryTree.postorder_traverse()
