import struct
import sys
import wfdb

if __name__  == "__main__":
   
    filename = ""
    output_file = ""

    if len(sys.argv) < 3:
        print("Input file and outputfile name is required")
        exit(-1)
    else:
        filename = sys.argv[1]
        output_file = sys.argv[2]

    with open(output_file + ".bin", 'wb') as f:
        signals, fields = wfdb.rdsamp(filename, channels=[0])
        for sig in signals:
            f.write(struct.pack("<f", sig[0]))