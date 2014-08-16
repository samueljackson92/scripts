import operator
import os
import os.path

def createHistOfTokens(documents):
	"""
	Count the occurance of each of the tokens in the documents list

	@param documents - list of documents comprised of indivdual tokens
	@return histogram of token counts
	"""
	hist = {}
	for doc in documents:
		for token in doc:
			if token in hist:
				hist[token] += 1
			else:
				hist[token] = 1

	return hist

def loadFiles(files):
	"""
	Load a list of files as strings

	@param files - the list of file paths to load from
	@return list of strings for each document
	"""
	documents = []
	for fname in files:
		with open(fname) as fhandle:
			doc = fhandle.read()
			documents.append(doc)

	return documents

def processDocuments(documents):
	"""
	Process the document strings to convert text to tokens

	@param documents - the raw text strings for each document
	@return list of tokens for each document
	"""
	documents = [doc.split() for doc in documents]
	documents = [[token.lower().strip('.!";,') for token in doc if token != ''] for doc in documents]
	return documents

def loadDocs(path):
	"""
	Load and process documents from file

	@param path - the path of the folder containing text files to load
	@return list of processed documents
	"""
	files = [ os.path.join(path,f) for f in os.listdir(path) if os.path.isfile(os.path.join(path,f)) ]
	docs = loadFiles(files)
	docs = processDocuments(docs)
	
	return docs 


if __name__ == "__main__":
	path = "/home/samuel/Desktop/books"

	print sorted(hist.iteritems(), key=operator.itemgetter(1), reverse=True)[:10]