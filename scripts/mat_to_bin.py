import scipy.io as sc
import struct
import matplotlib.pyplot as plt
import sys

if __name__  == "__main__":

    filename = ""

    if len(sys.argv) < 2:
        print("Input file name is required")
        exit(-1)
    else:
        filename = sys.argv[1]

    data = []
    with open(filename + ".bin", 'wb') as f:
        mat = sc.loadmat(filename)
        for i in range(1500, 12500):
            f.write(struct.pack("<f", mat["data_ECG"][i][0]))
            data.append(mat["data_ECG"][i][0])
    plt.plot(data)
    plt.show()