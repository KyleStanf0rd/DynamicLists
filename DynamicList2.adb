with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Lab2C is
   package IIO is new Ada.Text_IO.Integer_IO(integer);
   use IIO;
   package IIO2 is new Ada.Text_IO.Float_IO(Float);
   use IIO2;
   --MAKING ENUMERATION TYPES
   --DEPARTMENT TYPES
   type DepartmentType is (Sales, Crew, IT, Media, Accounting, noDept);
   package DeptTypeIO is new Ada.Text_IO.Enumeration_IO(DepartmentType);  use DeptTypeIO;
   --TITLE TYPES
   type TitleType is (manager, Sales_person, Designer, Programmer, Software_Engineer, spokesPerson, Pilot, Copilot, scientist, missionSpecialist, noTitle );
   package TitleTypeIO is new Ada.Text_IO.Enumeration_IO(TitleType);  use TitleTypeIO;
   --INSTRUCTION TYPES
   type Instruction is (IL, IR, DL, DR, DD, PA, PD);
   package InstructionTypeIO is new Ada.Text_IO.Enumeration_IO(Instruction); use InstructionTypeIO;
   --NAME TYPES
   type NameType is (Bob, Mary, Sally, David, Marty, Vallerie, Sam, Joe, noName);
   package NameTypeIO is new Ada.Text_IO.Enumeration_IO(NameType);  use NameTypeIO;




   --DELCARING THINGS TO READ AND WRITE FILES
   fileIn, fileOut: File_Type;
   inst : Instruction;
   deptName: DepartmentType;
   emp: NameType;
   title: TitleType;
   ID : integer;
   Payrate : float;



   --DECLARATIONS FOR LINKED CIRCULAR LIST
   type EmpNode;
   type EmpPt is access EmpNode;
   type EmpNode is record
      deptName: DepartmentType;
      empName: NameType;
      title:  TitleType := noTitle;
      ID:integer;
      Payrate: float;
      Next: EmpPt := null;
   end record;

   type DepartmentNode;
   type DeptPt is access DepartmentNode;
   type DepartmentNode is record
     deptName: DepartmentType;
     --empName: NameType;
     num: Integer := 0;
     next: EmpPt := null;
  end record;
   sortDepartment: array( DepartmentType ) of DepartmentNode;
   lp : EmpPt;


   --PROCEDURES!!
   --Insert Node on the Left Procedure!!!
   procedure insertNodeLeft(deptNameIn: DepartmentType; empNameIn:NameType; titleIn: TitleType; IDin: Integer; Payratein : Float) is
      pt: EmpPt;
   begin
     pt := new EmpNode'(deptNameIn, empNameIn, titleIn, IDin, Payratein,  null);
     if( sortDepartment(deptNameIn).next = Null ) then  -- empty list
        pt.next := pt;
        sortDepartment(deptNameIn).next := pt;
        lp := pt;
      else               -- list not empty
         lp.next := sortDepartment(deptNameIn).next;
         for index in 1..sortDepartment(deptNameIn).num loop --Getting lp to the bottom of the list
            lp := lp.next;
         end loop;
         pt.next := sortDepartment(deptNameIn).next;
         lp.next:= pt;

         sortDepartment(deptNameIn).next := pt;
     end if;
     sortDepartment(deptNameIn).num := sortDepartment(deptNameIn).num + 1;
   end insertNodeLeft;





   --Insert Node on the Right Procedure
   procedure insertNodeRight(deptNameIn: DepartmentType; empNameIn: NameType; titleIn: TitleType; IDin: Integer; Payratein : Float) is
      pt: EmpPt;

   begin
      pt := new EmpNode'(deptNameIn, empNameIn, titleIn, IDin, Payratein,  null);
      if( sortDepartment(deptNameIn).next = Null ) then
         pt.next := pt;
         sortDepartment(deptNameIn).next := pt;
      else
         lp.next := sortDepartment(deptNameIn).next; --Priming her up
         for index in 1..sortDepartment(deptNameIn).num loop --Getting lp to the bottom of the list
            lp := lp.next;
         end loop;
         lp.next := pt;
         pt.next := sortDepartment(deptNameIn).next;
         lp:= pt;
      end if;
      sortDepartment(deptNameIn).num := sortDepartment(deptNameIn).num + 1;
   end insertNodeRight;





   --Delete Node on the Left Procedure!!
   procedure deleteNodeLeft(deptNameIn: DepartmentType) is
      pt: EmpPt;
      y: EmpPt;
   begin
     if(sortDepartment(deptNameIn).next = Null) then
        put("Error: Department List is empty.\n");
      else
         lp.next := sortDepartment(deptNameIn).next;

         for index in 1..sortDepartment(deptNameIn).num loop --Getting lp to the bottom of the list
            lp := lp.next;
         end loop;
         pt := sortDepartment(deptNameIn).next;
         y := pt;
         lp.next := pt.next;
         sortDepartment(deptNameIn).next := pt.next;
         if(pt = lp) then
            pt := Null;
         end if;

     end if;
      sortDepartment(deptNameIn).num := sortDepartment(deptNameIn).num -1;

   end deleteNodeLeft;




   --Delete Node on the Right Procedure
   procedure deleteNodeRight(deptNameIn: DepartmentType) is
      pt: EmpPt;
      y: EmpPt;
      nn : EmpPt;
   begin
      if(sortDepartment(deptNameIn).next = Null) then
        put("Error: Department List is empty.\n");
      else
         lp.next := sortDepartment(deptNameIn).next;
         for index in 1..sortDepartment(deptNameIn).num-1 loop --Getting lp to the bottom of the list
            lp := lp.Next;
         end loop;
         pt := lp.Next;
         y := pt;
         nn := lp.Next;
         lp.next:= sortDepartment(deptNameIn).next;
         nn := lp;
         if pt = nn then
            nn := Null;
         end if;
      end if;
      sortDepartment(deptNameIn).num := sortDepartment(deptNameIn).num-1;
   end deleteNodeRight;




   --Procedure to delete a department!!
   procedure deleteDepartment(deptNameIn: DepartmentType) is
      pt: EmpPt;
   begin
      pt := sortDepartment(deptNameIn).next;
      pt.next:= pt;
      pt.empName := noName;
      pt.title := noTitle;
      pt.ID := 0;
      pt.Payrate := 0.0;
      sortDepartment(deptNameIn).num := 1;
   end deleteDepartment;



   --Is this a good way to structure my print statement? I thought it was better than doing 3 different for loops printing out the 3 different Department types
   --Print Every Department
   procedure printAllDepartment is
      pt: EmpPt;
      count : Integer := 1;
      deptTypes : array(1..3) of DepartmentType;
   begin
      --Assigning an array to equal each one of the enum types so I can loop through this.
      deptTypes(1) := DepartmentType(SALES);
      deptTypes(2) := DepartmentType(MEDIA);
      deptTypes(3) := DepartmentType(CREW);
      New_Line;
      New_Line(fileOut);
      for index in 1..3 loop
        put(deptTypes(count)); put(" DEPARTMENT :"); New_Line(2);
        put(fileOut, deptTypes(count)); put(fileOut, " DEPARTMENT :"); New_Line(fileOut, 2);
        pt := sortDepartment(deptTypes(count)).next;
      for index in 1..sortDepartment(deptTypes(count)).num loop
         put("[ ");
         put(pt.empName);
         put(", ");
         put(pt.title);
         put(", ");
         put(Integer'Image(pt.ID));
         put(", ");
         IIO2.put(pt.Payrate, 3, 2, 0);
         put("]"); New_Line;
         New_Line(fileOut);
         put(fileOut, "[ ");
         put(fileOut, pt.empName);
         put(fileOut, ", ");
         put(fileOut, pt.title);
         put(fileOut, ", ");
         IIO.put(fileOut,pt.ID);
         put(fileOut, ", ");
         IIO2.put(fileOut, pt.Payrate, 3, 2, 0);
         put(fileout, "]"); New_Line(fileOut);
         pt:= pt.next;
         end loop;
         count := count + 1;
         New_Line(fileOut, 2);
         New_Line(2);
      end loop;
   end printAllDepartment;





   --Print Specific Department Function
   procedure printDepartment(deptNameIn: DepartmentType) is
      pt: EmpPt;
   begin
      New_Line;
      New_Line(fileOut);
      pt := sortDepartment(deptNameIn).next;
      put(deptNameIn); put(" DEPARTMENT : "); New_Line(2);
      put(fileOut, deptNameIn); put(fileOut, " DEPARTMENT : "); New_Line(fileOut, 2);
      for index in 1..sortDepartment(deptNameIn).num loop
         put("[ ");
         put(pt.empName);
         put(", ");
         put(pt.title);
         put(", ");
         put(Integer'Image(pt.ID));
         put(", ");
         Ada.Float_Text_IO.Put(pt.Payrate, 3, 2, 0);
         put("]"); New_Line;
         New_Line(fileOut);
         put(fileOut, "[ ");
         put(fileOut, pt.empName);
         put(fileOut, ", ");
         put(fileOut, pt.title);
         put(fileOut, ", ");
         IIO.put(fileOut,pt.ID);
         put(fileOut, ", ");
         IIO2.put(fileOut, pt.Payrate, 3, 2, 0);
         put(fileout, "]"); New_Line(fileOut);
         pt:= pt.next;
         pt:= pt.next;
      end loop;
      New_Line(2);
   end printDepartment;



--MAIN!!
begin
   Open(fileIn, In_File, "DynList.txt");
   Create(fileOut, Out_File, "L2Out.txt");


   for index in 1..13 loop
      --Getting my instruction type so I can filter the functions
      InstructionTypeIO.get(fileIn, inst);
      --Filtering
      case inst is
         when IL => --I chose Insert left first since it is the most used in the read file(runtime will improve slightly)
            DeptTypeIO.get(fileIn, deptName);
            NameTypeIO.get(fileIn, emp);
            TitleTypeIO.get(fileIn, title);
            IIO.get(fileIn, ID);
            IIO2.get(fileIn, Payrate);

            insertNodeLeft(deptName,emp, title, ID, Payrate);

         when IR => null; --Insert Right is the second most used in the read file
            DeptTypeIO.get(fileIn, deptName);
            NameTypeIO.get(fileIn, emp);
            TitleTypeIO.get(fileIn, title);
            IIO.get(fileIn, ID);
            IIO2.get(fileIn, Payrate);

            insertNodeRight(deptName,emp, title, ID, Payrate);

         when PD => --Print Department is the third most used Instruction
            DeptTypeIO.get(fileIn, deptName);
            printDepartment(deptName);

         when PA => --From here they are all used the same

            printAllDepartment;

         when DL =>
            DeptTypeIO.get(fileIn, deptName);
            deleteNodeLeft(deptName);

         when DR =>
            DeptTypeIO.get(fileIn, deptName);
            deleteNodeRight(deptName);

         when DD =>
            DeptTypeIO.get(fileIn, deptName);
            deleteDepartment(deptName);

      end case;

   end loop;

   Close(fileIn);
   Close(fileOut);




   null;
end Lab2C;
