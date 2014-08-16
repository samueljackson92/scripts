#Python Cleaning Script
import os
import Tkinter, tkMessageBox
from shutil import rmtree

root = Tkinter.Tk()
root.withdraw()

HOME_VAR = "HOME"

if os.name == 'nt':
	HOME_VAR = "UserProfile"

def main():
	if tkMessageBox.askokcancel("Automated Clean Up", "System Requests Running Automated Clean Up Script. Continue?"):
	
		print "Beginning Cleanup..."
		folder = os.getenv("HOME") + "/Downloads"

		print "Clearing Downloads..."
		
		for the_file in os.listdir(folder):
			file_path = os.path.join(folder, the_file)
			try:
				if os.path.isfile(file_path):
					os.unlink(file_path)
				elif os.path.isdir(file_path):
					rmtree(file_path)
					
			except Exception, e:
				print e
	
if __name__ == "__main__":
	main()
