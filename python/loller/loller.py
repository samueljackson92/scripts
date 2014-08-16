from argparse import ArgumentParser
import re
import os
class KeywordParser():
	self.keys = {
		"CAN HAS" : "#include",
		"BIGGER THAN" : ">",
		"LOWER THAN" : "<",
		"IZ" : "if",
		"LIEK" : "==",
	}

def parseToken(token):
	#write includes
	pattern = re.compile(r"^\s?CAN HAS")
	if pattern.search(token):
		token = re.sub(r"^CAN HAS", "#include", token)
		token = re.sub(r"\w+\?$", lambda m: "<" + m.group(0)[:-1] + ".h>", token)

	#define variables
	pattern = re.compile(r"^\s?I HAS A")
	if pattern.search(token):
		token = re.sub(r"^I HAS A", "int", token)
		token = re.sub(r"\w+$", lambda m: m.group(0) + "=0;", token)

	pattern= re.compile(r"^\s?UP")
	if pattern.search(token):
		token = re.sub(r"!!", "+=", token)
		token = re.sub(pattern, " ", token)
		token += ';'

	pattern= re.compile(r"^\s?VISIBLE")
	if pattern.search(token):
		token = re.sub(r"VISIBLE", "printf(\"%s\\\\n\", ", token)
		token += ')'
		token += ";"

	pattern = re.compile(r"^\s?IZ")
	if pattern.search(token):
		token = re.sub(pattern, "if(", token)
		token = re.sub(r"BIGGER THAN", ">", token)
		token = re.sub(r"\?", ")", token)
		token = re.sub(r"KTHXBYE", "break;", token)


	token = re.sub(r"\s?IM IN YR LOOP", "while(1) {", token)
	token = re.sub(r"\s?IM OUTTA YR LOOP", "}", token)
	return token.lower()

if __name__ ==  "__main__":
	print "Starting loller..."

	parser = ArgumentParser(description="A LOLCODE compiler.")
	parser.add_argument('-f', '--file', 
			type=str, nargs=1, required=True, 
			help='Filename to compile.')

	args = parser.parse_args()

	with open(args.file[0], 'r') as content_file:
		data = content_file.read()

   	data = data.strip().split('\n')

   	#parse tokens, convert to C
   	for i,token in enumerate(data):
   		token = parseToken(token)
   		data[i] = token

   	print data
   	a = data.index("hai")
   	for i, d in enumerate(data):
   		if re.match(r"^\s?#include", d):
   			b = i
   	data[a], data[b] = data[b], data[a]

   	data = [re.sub(r"^hai$", "int main(int argc, char** argv) {", token) 
   			for token in data]
   	data = [re.sub(r"^kthxbye$", "}", token) for token in data]

   	with open("test.c", 'w') as output:
   		for d in data:
   			output.write(d + "\n")
   		output.close()

   	#run program
   	os.system("gcc test.c -o test")