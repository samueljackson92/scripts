import xlrd
import csv
import json
import re

import pylab

headings = []
table = []

def csv_from_excel():
	wb = xlrd.open_workbook('data.xls')
	sh = wb.sheet_by_name('KS209EW_Percentages')
	your_csv_file = open('your_csv_file.csv', 'wb')
	wr = csv.writer(your_csv_file, dialect=csv.excel, quoting=csv.QUOTE_ALL)

	for rownum in xrange(sh.nrows):
		wr.writerow(sh.row_values(rownum))

	your_csv_file.close()

def read_csv():
	global headings
	global table

	START_PATTERN = re.compile(r"^[A-Z][0-9]+$")
	HEADINGS_PATTERN = re.compile(r"^Area code$")

	with open('your_csv_file.csv', 'rb') as f:
	    reader = csv.reader(f)
	    for row in reader:
	    	if any(row):
	    		#remove empty values
	    		row = [item for item in row if item != ""]

	    		if re.match(HEADINGS_PATTERN, row[0]):
	    			headings = row
	        	elif re.match(START_PATTERN, row[0]):
	        		table.append(row)
	    f.close()

def export_to_json():
	global headings
	global table

	if headings and table:
		data = []
		for row in table:
			data_row = {}
			for i,item in enumerate(row):
				data_row[headings[i]] = item
			data.append(data_row)


		pylab.figure(1, figsize=(6,6))
		ax = pylab.axes([0.1, 0.1, 0.8, 0.8])

		pie_data = [data[0][key] for key in headings[3:]]
		explode = tuple([float(d)/float(1000) for d in pie_data])
		pylab.pie(pie_data, labels=headings[3:], explode=explode, autopct='%1.1f%%')
		pylab.show()
		print json.dumps(data, sort_keys=True, indent=4, separators=(',', ': '))

csv_from_excel()
read_csv()
export_to_json()




			

