import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse
import time
starttime = time.time()         # this is our start time
t = 0

plt.ion()
plt.axis("equal")
plt.xlim(-5,5)
plt.ylim(0,10)


#Variables of diagram
min_radius = 2
squash_factor = 2
vert_offset = 5

plt.axvline(linewidth=1, color='k')

circle1=Ellipse(xy=(0,vert_offset), width=min_radius, height=min_radius*squash_factor, angle=0, 
	color='k', linewidth=1, fill=False)
fig = plt.gcf()
fig.gca().add_artist(circle1)

while(t < 5.0):
	circle1=Ellipse(xy=(0,vert_offset), width=min_radius, height=min_radius*squash_factor, angle=0, 
	color='k', linewidth=1, fill=False)
	t = time.time() - starttime
	squash_factor += 0.01
	plt.draw()