################################################
# Simple Graph
# Author: 	Samuel Jackson
# Created:	28/1/13
################################################

class Node:
	def __init__(self, data):
		self.adjacents = []
		self.set_data(data)
		self.set_visited(False)

	def add_adjacent(self, node):
		self.adjacents.append(node)

	def set_visited(self, state):
		self.visited = state

	def is_visited(self):
		return self.visited

	def get_data(self):
		return self.data

	def set_data(self, data):
		self.data = data

class Graph:
	def __init__(self):
		self.nodes = {}

	def add_node(self, key, val):
		self.nodes[key] = Node(val)

	def add_adjacent(self, key, node_key):
		self.nodes[key].add_adjacent(node_key)

	def get_node(self, key):
		return self.nodes[key].get_data()

	def node_visited(self, key):
		return self.nodes[key].get_visited()

	def mark_node_visited(self, key):
		self.nodes[key].set_visited(True)