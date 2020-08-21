drop table EMPLOYEE;
drop table DEPARTEMNT;
drop table DEPENDENT;
drop table DEPT_LOCATIONS:
drop table PROJECT:
drop table WORKS_ON;

Create table EMPLOYEE(Fname char(15),
Minit char(2),
Lname char(15),
Ssn int,
Bdate date,
Address varchar(100) ,
Sex char(2),
Salary int,
Super_ssn int,
Dno int,
PRIMARY KEY(Ssn)
);


Create table DEPARTMENT(Dname varchar(20) ,
Dnumber int PRIMARY KEY,
Mgr_ssn int,
Mgr_start_date date,
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn) ON DELETE CASCADE
);



Create table DEPT_LOCATIONS(
Dnumber int ,
Dlocation varchar(20),
FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber) ON DELETE CASCADE
);

Create table PROJECT(Pname varchar(20),
Pnumber int,
Plocation varchar(20),
Dnum int,
PRIMARY KEY(Pnumber),
FOREIGN KEY (Dnum) REFERENCES Department(Dnumber) ON DELETE CASCADE
);


Create table WORKS_ON(Essn int,
Pno int,
Hours float,
FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber) ON DELETE CASCADE,
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) ON DELETE CASCADE
);

Create table DEPENDENT(Essn int,
Dependent_name varchar(20),
Sex char(1),
Bdate date,
Relationship varchar(20),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) ON DELETE CASCADE
);


Insert into EMPLOYEE values('John','B','Smith',123456789,to_date('1965-01-09', 'yyyy-mm-dd'),'731 Fondren,Houston, TX','M',30000,333445555,5);
Insert into EMPLOYEE values('Franklin','T','Wong',333445555,to_date('1955-12-08', 'yyyy-mm-dd'),'638 Voss,Houston, TX','M',40000,888665555,5);
Insert into EMPLOYEE values('Alicia','J','Zelaya',999887777,to_date('1968-01-19', 'yyyy-mm-dd'),'3321 Castle, Spring, TX','F',25000,987654321,4);
Insert into EMPLOYEE values('Jennifer','S','Wallace',987654321,to_date('1941-06-20', 'yyyy-mm-dd'),'291 Berry, bellaire, TX','F',43000,888665555,4);
Insert into EMPLOYEE values('Ramesh','K','Narayan',666884444,to_date('1962-09-15', 'yyyy-mm-dd'),'975 Fire Oak, Humble, TX','M',38000,333445555,5);
Insert into EMPLOYEE values('Joyce','A','English',453453453,to_date('1972-07-31', 'yyyy-mm-dd'),'5631 Rice, Houston, TX','F',25000,333445555,5);
Insert into EMPLOYEE values('Ahmad','V','Jabbar',987987987,to_date('1969-03-29', 'yyyy-mm-dd'),'980 Dallas, Houston, TX','M',25000,987654321,4);
Insert into EMPLOYEE values('James','E','Borg',888665555,to_date('1937-11-10', 'yyyy-mm-dd'),'450 Stone, Houston,TX','M',55000,NULL,1);

Insert into DEPARTMENT values('Research',5,333445555,to_date('1988-05-22', 'yyyy-mm-dd'));
Insert into DEPARTMENT values('Administration',4,987654321,to_date('1995-01-01', 'yyyy-mm-dd'));
Insert into DEPARTMENT values('Headquaters',1,888665555,to_date('1981-06-19', 'yyyy-mm-dd'));


Insert into DEPT_LOCATIONS values(1 ,'Houston');
Insert into DEPT_LOCATIONS values(4 ,'Stafford');
Insert into DEPT_LOCATIONS values(5 ,'Bellaire');
Insert into DEPT_LOCATIONS values(5 ,'Sugarland');
Insert into DEPT_LOCATIONS values(5 ,'Houston');

Insert into PROJECT values('ProductX', 1, 'Bellaire',5);
Insert into PROJECT values('ProductY', 2, 'Sugarland',5);
Insert into PROJECT values('ProductZ', 3, 'Houston',5);
Insert into PROJECT values('Computerization', 10, 'Stafford',4);
Insert into PROJECT values('Reorganization', 20, 'Houston',1);
Insert into PROJECT values('Newbenefits', 30, 'Stafford',4);

Insert into WORKS_ON values(123456789,1,32.5);
Insert into WORKS_ON values(123456789,2,7.5);
Insert into WORKS_ON values(666884444,3,40.0);
Insert into WORKS_ON values(453453453,1,20.0);
Insert into WORKS_ON values(453453453,2,20.0);
Insert into WORKS_ON values(333445555,2,10.0);
Insert into WORKS_ON values(333445555,3,10.0);
Insert into WORKS_ON values(333445555,10,10.0);
Insert into WORKS_ON values(333445555,20,10.0);
Insert into WORKS_ON values(999887777,30,30.0);
Insert into WORKS_ON values(999887777,10,10.0);
Insert into WORKS_ON values(987987987,10,35.0);
Insert into WORKS_ON values(987987987,30,5.0);
Insert into WORKS_ON values(987654321,30,20.0);
Insert into WORKS_ON values(987654321,20,15.0);
Insert into WORKS_ON values(888665555,20,NULL);

Insert into DEPENDENT values(333445555,'Alice','F',to_date('1986-04-05', 'yyyy-mm-dd'),'Daughter');
Insert into DEPENDENT values(333445555,'Theodore','M',to_date('1983-10-25', 'yyyy-mm-dd'),'Son');
Insert into DEPENDENT values(333445555,'Joy','F',to_date('1958-05-03', 'yyyy-mm-dd'),'Spouse');
Insert into DEPENDENT values(987654321,'Abner','M',to_date('1942-02-28', 'yyyy-mm-dd'),'Spouse');
Insert into DEPENDENT values(123456789,'Micheal','M',to_date('1988-01-04', 'yyyy-mm-dd'),'Son');
Insert into DEPENDENT values(123456789,'Alice','F',to_date('1988-12-30', 'yyyy-mm-dd'),'Daughter');
Insert into DEPENDENT values(123456789,'Elizabeth','F',to_date('1967-05-05', 'yyyy-mm-dd'),'Spouse');

DECLARE
emp_ssn EMPLOYEE.Ssn%type;
oldsal EMPLOYEE.Salary%type;
newsal Employee.Salary%type;
dno Employee.Dno%type;
mgrssn DEPARTMENT.Mgr_ssn%type;
emp_fname Employee.Fname%type;
emp_lname Employee.Lname%type;
flag int:=0;
--count1 int:=Select count(*) from ;
no_of_employess int:=0;
half_of_employees int:=0;
CURSOR raise_sal IS Select ssn,Salary,Dno from Employee;
CURSOR dept_c IS Select Mgr_ssn from Department;
cursor topsal IS select Fname,Lname, Salary from EMPLOYEE order by Salary desc;
BEGIN

OPEN raise_sal;
Loop
FETCH raise_sal INTO emp_ssn,oldsal,dno;
EXIT WHEN raise_sal%NOTFOUND;
OPEN dept_c;
Loop
FETCH dept_c INTO mgrssn;
EXIT when dept_c%NOTFOUND;
IF (emp_ssn=mgrssn)  THEN
flag:=1;
ELSE
newsal:=oldsal;
END IF;
END Loop;
close dept_c;
IF(flag=1)
THEN Update Employee set Salary=Salary*1.2 WHERE Ssn=emp_ssn;
ELSIF (dno=1)
THEN Update Employee set Salary=Salary*1.1 WHERE Ssn=emp_ssn;
ELSIF (dno=2)
THEN Update Employee set Salary=Salary*1.15 WHERE Ssn=emp_ssn;
ELSIF (dno=3)
THEN Update Employee set Salary=Salary*1.18 WHERE Ssn=emp_ssn;
ELSE
newsal:=oldsal;
END IF;
flag:=0;
END Loop;
CLOSE raise_sal;

OPEN topsal;
  LOOP
    FETCH topsal INTO emp_fname,emp_lname,newsal;
    EXIT WHEN topsal%NOTFOUND;
    no_of_employess:=no_of_employess+1;
    IF(no_of_employess=1) THEN
    dbms_output.put_line(emp_fname||' '||emp_lname||' '||newsal);
    END IF;
    END LOOP;
CLOSE topsal;
   
half_of_employees:=no_of_employess/2;
OPEN topsal;
    LOOP
    FETCH topsal INTO emp_fname,emp_lname,newsal;
    no_of_employess:=no_of_employess-1;
    EXIT WHEN no_of_employess<half_of_employees;
    dbms_output.put_line(emp_fname||' '||emp_lname||' '||newsal);
    
    END LOOP;
CLOSE topsal;
END;
    