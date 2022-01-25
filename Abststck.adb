with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
package body Abststck is
   
   --insertNodeLeft Procedure. This inserts a new element on the leftmost side of the list in the department stack.
   procedure insertNodeLeft(deptStack: access AbstractStack; pt: in AbstractStackElementPtr) is
      lp:AbstractStackElementPtr;
   begin
      if(deptStack.next = Null) then
         pt.next := pt;
         deptStack.next := pt;
         lp := pt;
      else
         lp.next := deptStack.next;
         for index in 1..deptStack.num loop --Getting lp to the bottom of the list
            lp := lp.next;
         end loop;
         pt.next := deptStack.next;
         lp.next:= pt;
         deptStack.next := pt;
      end if;
      deptStack.num := deptStack.num+1;
   end Abststck;
   
   --insertNodeRight procedure. This inserts a new element on the rightmost side of the list in the department stack.
   procedure insertNodeRight(deptStack: access AbstractStack; pt: in AbstractStackElementPtr) is
      lp:AbstractStackElementPtr;
   begin
      if(deptStack.next = Null) then
         pt.next := pt;
         deptStack.next := pt;
      else
         lp.next := deptStack.next;
         for index in 1..deptStack.num loop --Getting lp to the bottom of the list
            lp := lp.next;
         end loop;
         lp.next := pt;
         pt.next := deptStack.next;
         lp:= pt;
      end if;
      deptStack.num := deptStack.num+1;
   end insertNodeRight;
   
   
   --deleteNodeLeft Procedure. This deletes the left most element of the list in the department stack
   procedure deleteNodeLeft(deptStack: access AbstractStack) is 
      pt: AbstractStackElementPtr;
      y: AbstractStackElementPtr;
   begin
      if(deptStack(CorNstack).next = Null) then
         put("Error: Department List is empty.\n");
      else
         lp.next := deptStack.next;
         for index in 1..deptStack.num loop --Getting lp to the bottom of the list
            lp := lp.next;
         end loop;
         pt := deptStack.next;
         y := pt;
         lp.next := pt.next;
         deptStack.next := pt.next;
         if(pt = lp) then
            pt := Null;
         end if;
      end if;
      deptStack.num := deptStack.num - 1;
      end deleteNodeLeft;
      
   
   --deleteNodeRight procedure. This deletes the right most element of the list in the department stack.
  procedure deleteNodeRight(deptStack: access AbstractStack) is 
      pt: AbstractStackElementPtr;
      y: AbstractStackElementPtr;
     nn: AbstractStackElementPtr;
  begin
     if(deptStack.next = Null) then
         put("Error: Department List is empty.\n");
     else
        lp.next := deptStack.next;
        for index in 1..deptStack.num-1 loop --Getting lp to the bottom of the list
            lp := lp.next;
        end loop;
        pt := lp.Next;
        y := pt;
        nn := lp.Next;
        lp.next:= deptStack.next;
        nn := lp;
        if pt = nn then
           nn := Null;
        end if;
     end if;
     deptStack.num := deptStack.num - 1;
   end deleteNodeRight;
   
   --deleteDepartment Procedure. This deletes the whole list pointed to by the department stack.
   procedure deleteDepartment(deptStack: access AbstractStack) is
   pt: AbstractStackElementPtr;
   begin
      pt := deptStack.next;
      pt.next:= pt;
   end deleteDepartment;
end Abststck;
