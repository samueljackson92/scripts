
class Node:
	def __init__(self):
		self.adjacents = []
		self.visited = False

	def add_adjacent(self, node):
		self.adjacents.append(node)

	def set_visited(self, state):
		self.visited = state

	def is_visited(self):
		return self.visited

class Graph:
	def __init__(self):
		self.nodes = {}

	def hammingDistance(self, str1, str2):
		count  = 0

		for i in range(0, len(str1)):
			if str1[i] != str2[i]:
				count += 1

		return count

	def add_node(self, key, val):
		self.nodes[key] = val

	def add_adjacent(self, key, node):
		self.nodes[key].add_adjacent(node)

	def is_adjacent(self, key, other):
		return self.hammingDistance(key, other) == 1

	def get_node(self, key):
		return g.nodes[key]

	def find_path(self, start, finish):
		previous = {}
		queue = [start]
		self.get_node(start).set_visited(True)

		#dijkstra's Algorithm
		while (queue != []):
			t = queue.pop(0)
			if t == finish:
				break

			for node in g.get_node(t).adjacents:
				if not g.get_node(node).is_visited():
					previous[node] = t
					g.get_node(node).set_visited(True)
					queue.append(node)

		#build path
		path = []
		u = finish

		while u != start:
			path.append(u)
			u = previous[u]

		path += [start]
		return path[::-1]


if __name__ == '__main__':
	g = Graph()

	#load nodes
	file = open('dict4.dat', 'r');
	for line in file.xreadlines():
		line = line.strip()
		if(len(line) == 4):
			g.add_node(line, Node())
	file.close()

	#analyse adjacents
	keys = g.nodes.keys()
	for v in keys:
		for w in keys:
			if g.is_adjacent(v, w):
				g.add_adjacent(v, w)

	print "Graph Built!"

	path = g.find_path("head", "foot")
	print path