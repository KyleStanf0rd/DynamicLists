with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
package body MakeCar is
   package IIO is new Ada.Text_IO.Integer_IO(integer);
   use IIO;
   
   procedure assignManu(aCar: in out Car; M: allType) is
   begin
      aCar.manu : M;
   end assignManu;
   
   procedure assigncType(aCar: in out Car; C:carType) is
   begin
      aCar.ctype : C;
   end assigncType;
   
   procedure assignID(acar: in out Car; i: Integer) is
   begin
      aCar.ID : i;
   end assignID;
   
   
   
   

   

end MakeCar;
