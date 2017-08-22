import matplotlib.pyplot as plt
import numpy as np

# data = np.loadtxt('repeatdata.dat')

f2 = open('DATAqq.txt','r')
lines = f2.readlines()

for line in lines:
   p = line.split(',')
   x1.append(float(p[0]))
   y1.append(float(p[1]))
xv = np.array(x1)
yv = np.array(y1)
plt.plot(xv,yv)
plt.show()
f2.close()
