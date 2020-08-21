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



select p.Pname,d.Dname,e.Fname,e.Address,e.Bdate from Employee e,Department d,Project p
  where p.plocation='Stafford' and p.Dnum=d.Dnumber and d.Mgr_ssn=e.Ssn;
  
  select e.Fname,e.Salary*1.1 as Salry_After_10_increment from Employee e,Works_on w,Project p
  where p.Pname='ProductX' and p.Pnumber=W.Pno and w.Essn=e.Ssn;
  
  select d.Dnumber,d.Dname,e.Fname,e.Lname,p.Pname from Employee e,Works_on w,Project p,Department d
  where p.Pnumber=w.Pno and p.Dnum=d.Dnumber and w.Essn=e.Ssn order by d.Dnumber asc,e.Lname asc,e.Fname asc;
  
create view tempwm as (Select e.Fname as mgr_fname,e.Lname as mgr_lname from employee e where e.Ssn in(select d.Mgr_ssn from department d where d.Dnumber=5));
select t.mgr_fname,t.mgr_lname,e.Fname,e.Lname from Employee e,Works_on w,Project p,tempwm t
  where p.Pname='ProductX' and p.Pnumber=W.Pno and e.Dno=p.Dnum and e.Dno=5 and e.Ssn=w.Essn and w.Hours>10;

select w.Essn,w.Pno,w.Hours from Works_on w,Works_on ws
  where w.Essn!=ws.Essn and w.Pno=ws.Pno and w.Hours=ws.Hours and w.Essn=123456789;

select e.Fname from Employee e where e.Ssn in (Select d.Essn from Dependent d where e.Fname=d.Dependent_name and e.Sex=d.Sex); 

Select d.Dname,SUM(e.Salary),MAX(e.Salary),MIN(e.Salary),AVG(e.Salary) from Employee e,Department d where e.Dno=d.Dnumber group by d.Dname having d.Dname='Research' ;

Select em.Dno,Count(*) from employee em
where em.Salary>=30000 and em.Dno in(Select e.Dno from employee e group by e.Dno having Count(*)>=3)
group by em.Dno;

Select * from employee;
Update employee e
SET e.salary = e.salary*1.1
where e.ssn in (Select d.Essn from dependent d where d.Relationship='Daughter' );
Select * from employee;

Update employee e
Set e.Dno=(Select Dloc.Dnumber from DEPT_LOCATIONS Dloc where Dloc.Dlocation ='Stafford')
where Extract(year from e.Bdate)=1965;
Select * from employee;

Create view lgv as Select w.Pno from Employee e,Works_on w where e.Ssn=w.Essn and e.Lname='Smith';
Create view gll as(Select w.Essn,t.Pno from Works_on w,lgv t MINUS Select Essn,Pno from Works_on );
Select e.Fname,e.Lname from Employee e where e.Ssn not in (Select distinct(gll.Essn) from gll) and e.Lname!='Smith';

Create View Dept_empdetail As select Count(*)as count_,SUM(e.Salary)as total_sal,e.Dno as Dept_num 
from Employee e group by e.Dno;
Select * from Dept_empdetail;

Alter table employee
ADD commission int;
Update employee
set commission=500 where dno=4 or dno=1;
Select Fname,Lname,Salary+NVL(commission,0) as Net_salary from employee;

Delete from Project where Pname='Newbenefits';
Select * from project;
Select * from works_on;

Create view llv as Select P.Pnumber from Project P where P.Plocation='Houston';
Create view tll as(Select w.Essn,t.Pnumber from Works_on w,llv t MINUS Select Essn,Pno from Works_on );
Select e.Fname,e.Lname from Employee e where e.Ssn not in (Select distinct(tll.Essn) from tll) ;

Select floor(months_between(sysdate,e.Bdate)/12) as Years,
MOD(trunc(months_between(sysdate,e.Bdate)),12) as Months, e.salary
from employee e,department d
where e.Dno=d.Dnumber and d.Dname='Research';


Create View Payroll as (Select e.Ssn as Payroll_Ssn,e.Fname as Payroll_Fname,e.Lname as Payroll_Lname,e.Dno as Payroll_Dno,e.Salary as Payroll_Salary from Employee e);
Select * from Payroll;
Update Payroll
Set Payroll_Salary=Payroll_Salary*1.1 where Payroll_Dno=5;
Select * from employee;
Select * from Payroll;





