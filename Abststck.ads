generic
   type deptType is private;
   type nameType is private;
   type TitleType is private;
   type carManu is private;
   type allType is private;
   type carType is private;
   
package Abststck is
   type AbstractStack is limited private;
   type AbstractStackElement is tagged private;

  
   type AbstractStackElementPtr is access all AbstractStackElement'Class;
   
   procedure insertNodeLeft(deptStack: access AbstractStack; pt: in AbstractStackElementPtr);
   procedure insertNodeRight(deptStack: access AbstractStack; pt: in AbstractStackElementPtr);
   procedure deleteNodeRight(deptStack: access AbstractStack);
   procedure deleteNodeLeft(deptStack: access AbstractStack);
   procedure deleteDepartment(deptName: in deptType);
   
   
   private
   type AbstractStack is limited
      record
         num: integer := 0;
         next: AbstractStackElementPtr := null;
      end record;
   type AbstractStackElement is tagged record
      next: AbstractStackElementPtr;
   end record;
   



end Abststck;
