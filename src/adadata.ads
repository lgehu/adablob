
with Interfaces; use Interfaces;
with System;
use type Interfaces.IEEE_Float_32;

-- This file was generated with to_ada.py
-- File from makefile
package AdaData is
    type Data_Type is array (Positive range <>) of Unsigned_8;

    Data : aliased Data_Type(1 .. 841);
    for Data'Address use System'To_Address (16#08060000#);
   
    Data_Size   : constant Positive := 841;
    Sample_Rate : constant Positive := 100;

end AdaData;
                