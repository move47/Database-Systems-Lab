Create table student(
sroll char(9), 
sname varchar(15), 
gender char(1), 
branch char(3), 
programme varchar(5), 
CGPA float, 
PRIMARY KEY(sroll)
);
Create table company(
company_id int, 
name varchar(10), 
specification varchar(30), 
PRIMARY KEY(company_id)
);
Create table interview(
sroll char(9), 
company_id int, 
idate date,
FOREIGN KEY (sroll) REFERENCES student(sroll) ON DELETE CASCADE,
FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE
);
Create table offer(
sroll char(9), 
company_id int, 
osalary int,
FOREIGN KEY (sroll) REFERENCES student(sroll) ON DELETE CASCADE,
FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE
);

Insert into student values('17CS02002','SAI PRASATH','M','cse','dd',9.73);
Insert into student values('17CS02011','HIMANSHU GOYAL','M','cse','dd',9.32);
Insert into student values('17EE01051','DINESH MOHANTY','M','ee','btech',8.61);
Insert into student values('17MM01000','SHREYA','F','met','mtech',7.98);
Insert into student values('17EC02005','ROHAN','M','ece','btech',8.21);

Insert into company values(1,'Amazon','E-commerce gaint');
Insert into company values(2,'Google','God-father in technology');
Insert into company values(3,'Apple','Innovation');
Insert into company values(4,'Microsoft','Software Designers');

Insert into interview values('17CS02002',3,'2020-12-20');
Insert into interview values('17CS02002',2,'2020-12-20');
Insert into interview values('17CS02011',2,'2021-10-09');
Insert into interview values('17EE01051',1,'2020-09-08');
Insert into interview values('17MM01000',1,'2020-11-10');
Insert into interview values('17EC02005',4,'2019-11-15');

Insert into offer values('17CS02002',3,999999);
Insert into offer values('17CS02011',2,10000000);
Insert into offer values('17MM01000',1,99000);
Insert into offer values('17EC02005',4,78768);

select sname,branch from student where sroll in (select sroll from offer);

select sname from student where sroll in (select sroll from offer where osalary>100000);

select * from student where sroll in(select sroll from interview where sroll not in(select sroll from offer));

select sname from student where programme='DUAL' and sroll in (select sroll from offer);

select * from student where gender='F' and sroll in (select sroll from offer);

select BRANCH,COUNT(*) no_of_offer_recived from student where sroll in (select sroll from offer) group by branch;

select SNAME from student where sroll in (select sroll from offer where osalary in (select MAX(Osalary) from offer));

select s.sroll,s.sname,s.branch from student s where s.sroll in (select o.sroll from offer o where o.osalary in  
(select max(o.osalary) from student s,offer o where s.sroll=o.sroll group by s.branch));

CREATE VIEW temp_table as Select count(*) as offers_per_branch,s.branch from student s,offer o where s.sroll = o.sroll group by s.branch;
Select branch from temp_table where offers_per_branch in (Select MAX(offers_per_branch) from temp_table);
DROP VIEW temp_table;

select s.branch ,Count(s.branch) as no_of_student_didn_t_recive_offer from student where s.sroll not in (select o.sroll from offer o)group by s.branch

select s.sname,s.gender,s.branch,c.name,c.specification,o.osalary from student s,company c,offer o where
s.sroll=o.sroll and o.company_id=c.company_id


