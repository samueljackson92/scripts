from Tkinter import *
from tkSimpleDialog import askstring
import tkFont
from sys import exit
import feedparser
import webbrowser


blackList = []

def contains(str, q):
	return str.find(q) > -1
	
class Article(Frame):

	def createWidgets(self, data):
		ftTitle = tkFont.Font(family="Helvetica", size=14)
		title = Label(self, text=data.title, wraplength=500, font=ftTitle)
		desc = Label(self, text=data.description, wraplength=300)
		view = Button(self, text="View")
		close = Button(self, text="Close")
		title.pack()
		desc.pack()
		view.pack()
		close.pack()
		
	def __init__(self, master, data):
		Frame.__init__(self, master)
		self.pack()
		self.createWidgets(data)
		
#code for the black list window
class BlackList(Frame):
	def addTag(self):
		newtag = askstring("Add Tag", "Enter a new tag to filter:")
		self.lbBlackList.insert(END, newtag)
		blackList.append(newtag)
		fh = open("blacklist.txt", "a")
		fh.write(newtag + "\n")
		fh.close()

	def createWidgets(self):
		self.lbBlackList = Listbox(self, width=50)
		for x in blackList:
			self.lbBlackList.insert(END, x)
		self.lbBlackList.grid()

		self.btnAddTag = Button(self, text="Add", command=self.addTag).grid()
	
	def __init__(self, master=None):
		Frame.__init__(self, master)
		self.pack()
		self.createWidgets()

#main application instance		
class Application(Frame):
	def getNews(self):
		#delete all items in listbox
		self.lbItems.delete(0, END)
		self.googlenews = feedparser.parse("http://feeds.bbci.co.uk/news/rss.xml")

		for e in self.googlenews.entries:
			flag = False
			if len(blackList) != 0:
				for item in blackList:
					if contains(e.title.upper(), item[:-1].upper()):
						flag = True
			
			if flag == False:
				self.lbItems.insert(END, e.title)
				
	def editBlackList(self):
		blw = Toplevel(root)
		blw.title("Feeder: Black List")
		bl = BlackList(master=blw)
		
	def loadBlackList(self):
		fh = open('blacklist.txt', 'r')
		for line in fh:
			blackList.append(line)
		fh.close()
	
	def openArticle(self, e=None):
		selection = self.lbItems.curselection()
		for e in selection:
			e = int(e)
			data = self.googlenews.entries[e]
			artwin = Toplevel(root)
			artwin.title("Feeder: Article")
			article = Article(artwin, data)
		
	def openArticleInBrowser(self):
		selection = self.lbItems.curselection()
		for e in selection:
			e = int(e)
			url = self.googlenews.entries[e].link
			webbrowser.open(url)
	
	def createWidgets(self):
		menu = Menu(self)
		root.config(menu=menu)

		filemenu = Menu(menu)
		helpmenu = Menu(menu)
		
		menu.add_cascade(label="File", menu=filemenu)
		menu.add_cascade(label="Help", menu=helpmenu)
		
		filemenu.add_command(label="Get Feed", command=self.getNews)
		filemenu.add_command(label="Open", command=self.openArticle)
		filemenu.add_command(label="Open in browser", command=self.openArticleInBrowser)
		filemenu.add_command(label="Black List", command=self.editBlackList)
		filemenu.add_command(label="Exit", command=exit)
		
		helpmenu.add_command(label="About")
		helpmenu.add_command(label="Credits")
		
		self.yscroll = Scrollbar(self, orient=VERTICAL)
		self.lbItems = Listbox(self, width=80, height=10, yscrollcommand=self.yscroll.set)
		self.lbItems.bind("<Double-Button-1>", self.openArticle)
		self.yscroll.config(command=self.lbItems.yview)
		self.yscroll.grid(row=0, column=1)
		self.lbItems.grid(row=0)
		
	def __init__(self, master=None):
		Frame.__init__(self, master)
		
		self.pack()
		self.createWidgets()
		self.loadBlackList()
		self.getNews()

root = Tk()
root.geometry("%dx%d%+d%+d" % (500, 190, 100, 100))
root.title("Feeder")	
app = Application(master=root)
app.mainloop()
sys.exit()



