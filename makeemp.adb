with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
package body MakeEmp is
   package IIO is new Ada.Text_IO.Integer_IO(integer);
   use IIO;
   package IIO2 is new Ada.Text_IO.Float_IO(Float);
   use IIO2;
   
   procedure assignName(aEmp: in out Emp; N: in allType) is
   begin
      aEmp.empName:=N;
   end assignName;
   
   procedure assignTitle(aEmp: in out Emp; T: in TitleType) is
   begin
      aEmp.title:= T;
   end assignTitle;
   
   procedure assignID(aEmp: in out Emp; N: in Integer) is
   begin
      aEmp.ID:= N;
   end assignID;
   
   procedure assignPR(aEmp: in out Emp; PR: in Float) is
   begin
      aEmp.Payrate:= PR;
   end assignPR;
   
      

   

end MakeEmp;
