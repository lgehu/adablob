#!/usr/bin/env python3
import sys
import os
import argparse
import wfdb
import struct

def generate_ads(input_file, output_file, package_name, datalen, sample_rate, array_type):
    with open(output_file + ".ads", 'w') as f:
        f.write(f'''
with Interfaces; use Interfaces;
with System;
use type Interfaces.IEEE_Float_32;

-- This file was generated with {os.path.basename(__file__)}
-- File from {input_file}
package {package_name} is
    type Data_Type is array (Positive range <>) of {array_type};

    Data : aliased Data_Type(1 .. {datalen});
    for Data'Address use System'To_Address (16#08060000#);
   
    Data_Size   : constant Positive := {datalen};
    Sample_Rate : constant Positive := {int(sample_rate)};

end {package_name};
                ''')

def generate_blob(input_file, data):
    
    # Open the Ada output file
    with open("src/datablob.ads", "w") as f:
        
        f.write("with Interfaces; use Interfaces;\n")
        f.write(f'-- This file was generated with {os.path.basename(__file__)}\n')
        f.write(f"-- File from {input_file}\n")
        f.write(f"package DataBlob is\n")
        f.write(f"   type Data_Type is array (Positive range <>) of Unsigned_8;\n")
        f.write("   Blob : Data_Type := (\n")
      
        # Write the binary content in Ada array form
        for idx, byte in enumerate(data, start=1):
            if idx % 12 == 1:
                f.write("      ")  # indentation
            f.write(f"{byte}")

            if idx != len(data):
                f.write(", ")
                if idx % 12 == 0:
                    f.write("\n")
            else:
                f.write("\n")

        f.write(f"""
    );
    pragma Linker_Section (Blob, \".custom_data\");
    pragma Export (Ada, Blob, \"custom_data\");
end DataBlob;
                """)

def read_file(input_file, isWFDB):
    data = []
    if isWFDB:
        signals, fields = wfdb.rdsamp(input_file, channels=[0])
        sample_rate = fields['fs']
        print(fields)
        for sig in signals:
            data.append(sig[0])
            #bb = struct.pack('>h', int(sig[0] * 1000))
            #data.append(bb[0])
            #data.append(bb[1])
    else:
        with open(input_file, "rb") as f:
            data = f.read()
    return data

def parse_args():
    parser = argparse.ArgumentParser(description="Convert any file into an Ada array")

    parser.add_argument("input_file", help="Input file")
    parser.add_argument("output_file", help="Path and filename without extension")
    parser.add_argument("package_name", help="Package name in Ada")
    parser.add_argument("addr", help="Start address in the flash in hex format (Ex: 0x0806000)")
    parser.add_argument("-at", "--array-type", 
                        help="Available type defined in the interfac.ads file (Ada Runtime).",
                        default="Unsigned_8")
    parser.add_argument("-r", "--run",
                        action='store_true',
                        help="Run make right after to compile and flash the generated data")
    parser.add_argument("-w", "--wfdb", 
                        action='store_true',
                        help="Read the input file as a wfdb file. " \
                        "File extension must be omitted. ")

    return parser.parse_args()

if __name__ == "__main__":

    args = parse_args()
    
    data = read_file(args.input_file, args.wfdb)

    generate_blob(args.input_file, data)
    generate_ads(args.input_file, args.output_file, args.package_name, len(data), 100, args.array_type)

    if args.run:
        os.system(f"make ADDR={args.addr}")