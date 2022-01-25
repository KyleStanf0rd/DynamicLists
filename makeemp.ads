with Abststck;
generic
   type DepartmentType is private;
   type NameType is private;
   type TitleType is private;
   type carManu is private;
   type allType is private;
   type carType is private;

package MakeEmp is
   package Blist is new Abststck(DepartmentType,NameType, TitleType, carManu, allType, carType);

   type Emp is new Blist.AbstractStackElementPtr with record
      empName: allType;
      title:  TitleType;
      ID:integer;
      Payrate: float;
   end record;
   
   procedure assignName(aEmp: in out Emp; N: in allType);
   procedure assignTitle(aEmp: in out Emp; T: in TitleType);
   procedure assignID(aEmp: in out Emp; N: in integer);
   procedure assignPR(aEmp: in out Emp; PR: in float);
   
      

end MakeEmp;
