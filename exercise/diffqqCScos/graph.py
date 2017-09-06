import matplotlib.pyplot as plt
import numpy as np

datafile = open('DATAqq.txt','r')
data =  datafile.readlines()
datafile.close()

for row in data:
    this_data = row.split()

print type(this_data)

S = []
cs = []
for row in data:
    this_data = row.split()
    S.append(float(this_data[0]))
    cs.append(float(this_data[1]))

print '\n'
print type(S)

S = np.array([float(row.split()[0]) for row in data])
CS = np.array([float(row.split()[1]) for row in data])
print S
print CS

plt.plot(S,CS, linestyle = '-', color = 'darkgreen')
#fig = plt.figure()
#axes = fig.add_axes()
#axes.plot(S,CS, linestyle = 'none', color = 'darkgreen', marker = '.')
#axes.set_xlabel('hahaha')
#axes.set_xlabel('$ha$')

#axes.set_title('Cross section with respect to S')
plt.show()
