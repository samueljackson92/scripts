# heapsort.py
# Date: 15/06/13
# Author: Samuel Jackson (samueljackson@outlook.com)
# Description: Python implementation of a basic heapsort.
# Based heavily on the example code from http://en.wikipedia.org/wiki/Heapsort

import random

def swap(data, i, j):
	temp = data[i]
	data[i] = data[j]
	data[j] = temp

#convert our data into a max-order heap in place in the array
def heapify(data):
	#get position of last parent node in heap
	start = (len(data) -1) / 2

	while (start >= 0):
		#sift down from start such that all nodes below start are then in place
		siftDown(data, start, len(data)-1)
		start = start -1


#Re-organize the heap from a given point in the list to a given end point
def siftDown(data, start, end):
	root = start

	#while root has at least one child
	while (root * 2 + 1 <= end):
		child = root * 2 + 1 #get left child
		swapNode = root #keep track of node to swap with

		#check if left child needs to be swapped
		if(data[swapNode] < data[child]):
			swapNode = child

		#check if right child exists and needs to be swapped
		if(child+1 <= end and data[swapNode] < data[child+1]):
			swapNode = child+1

		#check if we need to swap
		if(swapNode != root):
			swap(data, root, swapNode)
			root = swapNode
		else:
			return

def heap_sort(data):

	end = len(data) -1

	#place data in max heap order
	heapify(data)

	while (end > 0):
		#swap the max element to the end
		print ">>", data
		swap(data, 0, end)
		end = end -1

		#re-heapify the data
		siftDown(data, 0, end)



d = random.sample(range(30), 10)

print d
heap_sort(d)
print d