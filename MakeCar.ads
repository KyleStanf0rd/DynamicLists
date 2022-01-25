with Abststck;
generic
   type allType is private;
   type carType is private;
   type DepartmentType is private;
   type Nametype is private;
   type Titletype is private;
   type carManu is private;
   

package MakeCar is
   package Blist is new Abststck(DepartmentType,NameType, TitleType, carManu, allType, carType);
   type Car is new Blist.AbstractStackElement with record
      manu: allType;
      ctype: carType;
      ID: Integer;
   end record;
   
   procedure assignManu(aCar: in out Car; M: allType);
   procedure assigncType(aCar: in out Car; C:carType);
   procedure assignID(acar: in out Car; i: Integer);

end MakeCar;
