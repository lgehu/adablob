# Adablob 
This tool allow the user to flash data to a specific adress in the FLASH memory on the STM32F446 series.

## PREREQUISITES (Linux)
You will need the following tools:
- [make](https://www.gnu.org/software/make/)
- [alire](https://github.com/alire-project/alire/releases/tag/v2.1.0)
- st-link: `sudo apt install stlink-tools`
- python3: `sudo apt install python3`

## How to use
First, you will have to transform your data to an ada array in order to be compiled.  
Example: `python3 scripts/to_ada.py alire.toml src/adadata AdaData 0x08060000 --array-type Unsigned_8`  
Here, the script reads the entire file 'alire.tom' and place it to an ada array of Unsigned_8.  
The array-type don't affect your data but is used to generate an .ads file to access your data.  
Then, the data will be placed at the adress 0x08060000. According to the F446RE board, it is the last available sector of the flash.  
For your usage, make sure the address is on an available sector with enough space and that it won't be overwritten by further compilation. 
The script will generate two files:  
- datablob.ads which contain your data.
- adadata.ads which define constants to access your data. You can copy this file into your project.
Finally, the 'r' argument run the compilation and flash the program, or you can manually compile with:
```bash
make ADDR=0x08060000
```
## Verify
According to the compiler, the address can change during the linking phase.
Sometime, the address has an offset due to alignment or metadata caused by the compiler.
You can check the real address using this command:
```bash
./scripts/verify.sh
```
Or check that your data are in the board with:
```bash
st-flash read dump.bin 0x08060000 434
hexdump -C dump.bin 
```
Or `od -f dump.bin` to display float numbers. 
