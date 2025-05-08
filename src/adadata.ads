
with Interfaces;
with System;
use type Interfaces.IEEE_Float_32;

package AdaData is
    pragma Elaborate_Body;
    type Data_Type is array (Positive range <>) of Interfaces.Unsigned_8;

    Data : aliased Data_Type(1 .. 584);
    for Data'Address use System'To_Address (16#08060000#);
   
    Data_Size   : constant Positive := 584;
    Sample_Rate : constant Positive := 0;

end AdaData;
                