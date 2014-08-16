import docparser

class MultinomialNaiveBayes():
	def __init__(self, classes, trainingData):
		#list of document classes
		self.classes = classes
		self.data = trainingData 

		#prior beliefs about a token
		self.prior = {}

		#probabilities of tokens belonging to a document
		self.probs = {name: {} for name in self.classes} 

	def train(self):
		vocab = docparser.createHistOfTokens(self.data)
		allDocs = [item for sublist in self.data.items() for item in sublist]
		noDocs = len(allDocs)

		for docClass in self.classes:
			noDocsInClass = len(self.data[docClass])
			self.prior[docClass] = noDocsInClass / noDocs
			
			tokenCounts = docparser.createHistOfTokens(self.data[docClass])
			totalTokenSum = sum(map(lambda x: x+1, tokenCounts.values()))

			for token in vocab:
				tokenCount = 0 if token not in tokenCounts else 1
				self.probs[docClass][token] = ( tokenCount + 1 ) / totalTokenSum

		return self.prior, self.probs

	def apply(self, documents):
		pass

if __name__ == "__main__":
	path = "/home/samuel/Desktop/books/training_data/"
	
	classNames = ['Fiction', 'Non-Fiction']
	trainingData = {}

	for className in classNames:
		trainingData[className] = docparser.loadDocs(path + className)

	bayes = MultinomialNaiveBayes(classNames, trainingData)
	bayes.train()