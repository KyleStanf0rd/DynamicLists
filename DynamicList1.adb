with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Abststck;
with MakeCar;
with MakeEmp;

procedure Lab2B is
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
   --ALL TYPES
   type allType is (Bob, Mary, Sally, David, Marty, Vallerie, Sam, Joe, noName, Chevy, Ford, GMC, Dodge, Chevy, noManu);
   package allTypeIO is new Ada.Text_IO.Enumeration_IO(allType); use allTypeIO;
   type carManu is (Chevy, Ford, GMC, Dodge, Chevy, noManu);
   package carManuIO is new Ada.Text_IO.Enumeration_IO(carManu); use carManuIO;
   type carType is (SUV, Raptor, Pickup, Ram, StingRay, noType);
   package carTypeIO is new Ada.Text_IO.Enumeration_IO(carType); use carTypeIO;

   package Blist is new Abststck(DepartmentType,NameType, TitleType, carManu, allType, carType);
   package mCar is new MakeCar(allType, carType, DepartmentType, NameType, Titletype, carManu);
   package mEmp is new MakeEmp(DepartmentType,NameType, TitleType, carManu, allType, carType);


   type Stack_Ptr is access Blist.AbstractStack;
   Newcar,Carpt, Newemp, Emppt, stackptr: Blist.AbstractStackElementPtr;



   deptStack : array(DepartmentType) of Stack_Ptr;

   --DECLARING THINGS TO READ AND WRITE FILES
   fileIn, fileOut: File_Type;
   inst : Instruction;
   deptName: DepartmentType;
   employee: NameType;
   title: TitleType;
   ID : integer;
   Payrate : float;
   manu: carManu;
   cType: carType;
   allT: allType;









begin
   Open(fileIn, In_File, "DynList.txt");
   Create(fileOut, Out_File, "L2BOut.txt");

   for index in 1..13 loop
      --Getting my instruction type so I can filter the functions
      InstructionTypeIO.get(fileIn, inst);
      case inst is
         when IL => --I chose Insert left first since it is the most used in the read file(runtime will improve slightly)
            DeptTypeIO.get(fileIn, deptName);
            allTypeIO.get(fileIn, allT);
            if(allT = NameType) then
               TitleTypeIO.get(fileIn, title);
               IIO.get(fileIn, ID);
               IIO2.get(fileIn, Payrate);
               Newemp:= new mEmp.Emp'(Blist.AbstractStackElementPtr with allT, title, ID, Payrate);
               Blist.insertNodeLeft(deptStack(deptName), Newemp);
            else
               carManuIO.get(fileIn, manu);
               carTypeIO.get(fileIn, cType);
               IIO.get(fileIn, ID);
               Newcar:= new Car'(AbstractStackElement with allT, manu, cType, ID);
               Blist.insertNodeLeft(deptStack(deptName), Newcar);
            end if;

         when IR =>
            DeptTypeIO.get(fileIn, deptName);
            allTypeIO.get(fileIn, allT);
            if(allT = NameType) then
               TitleTypeIO.get(fileIn, title);
               IIO.get(fileIn, ID);
               IIO2.get(fileIn, Payrate);
               Newemp:= new Emp'(AbstractStackElement with allT, title, ID, Payrate);
               Blist.insertNodeRight(deptStack(deptName), Newemp);
            else
               carManuIO.get(fileIn, manu);
               carTypeIO.get(fileIn, cType);
               IIO.get(fileIn, ID);
               Newcar:= new Car'(AbstractStackElement with allT, manu, cType, ID);
               Blist.insertNodeRight(deptStack(deptName), Newcar);
            end if;

         when PD =>
            DeptTypeIO.get(fileIn, deptName);
            null;

         when PA =>
            null;

         when DL =>
            DeptTypeIO.get(fileIn, deptName);
            Blist.deleteNodeLeft(deptStack(deptName));

         when DR =>
            DeptTypeIO.get(fileIn, deptName);
            Blist.deleteNodeRight(deptStack(deptName));

         when DD =>
            DeptTypeIO.get(fileIn, deptName);
            Blist.deleteDepartment(deptName);
            mEmp.assignName(Emp'Class(deptStack(deptName)), noName);
            mEmp.assignTitle(Emp'Class(deptStack(deptName)), noTitle);
            mCar.assigncType(Car'Class(deptStack(deptName)), noType);
            mCar.assignManu(Car'Class(deptStack(deptName)), noManu);
            mCar.assignID(Car'Class(deptStack(deptName)), 0);
            mEmp.assignPR(Emp'Class(deptStack(deptName)), 0.0);
            mEmp.assignID(Emp'Class(deptStack(deptName)), 0);
      end case;

   end loop;

   Close(fileIn);
   Close(fileOut);










end Lab2B;
