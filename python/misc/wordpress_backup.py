import subprocess

USER_NAME = "slj11"
SERVER = "central.aber.ac.uk"
DIR = "public_html/wordpress"

print "Wordpress automated backup"

address = USER_NAME + '@' + SERVER + ':' + DIR

print address
subprocess.call(['pscp', '-r', address, "C:\Users\Samuel\Documents\My Dropbox\docs\backup"])