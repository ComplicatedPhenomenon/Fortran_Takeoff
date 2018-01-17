import matplotlib.pyplot as plt
import numpy as np

datafile = open('result/DATAqq_3.txt','r')
data =  datafile.readlines()
datafile.close()

s = []
cs = []
for row in data:
    this_data = row.split()
    s.append(float(this_data[0]))
    cs.append(float(this_data[1]))


S = np.array(s)
CS = np.array(cs)

plt.plot(S,CS*10**3,'.g')
plt.xlabel("S")
plt.ylabel("fb")
plt.title('Cross section with respect to S with  $\delta =3 $')
plt.show()
plt.savefig("3.png")
