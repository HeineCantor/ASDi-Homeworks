import matplotlib.pyplot as plt
import numpy as np

X = np.asarray([10,    7,     6,     5.5,    5.25, 5])
Y = np.asarray([4.710, 1.710, 0.710, 0.210, -0.04, -0.290])

col = np.where(Y<0,'r', 'b')

plt.xlabel("Clock period (ns)")
plt.ylabel("Worst Negative Slack WLS (ns)")

plt.axhline(y=0, color='g', linestyle='-')

plt.plot(X, Y, 'k')
plt.scatter(X, Y, c=col)
plt.gca().invert_xaxis()
plt.grid()
plt.show()