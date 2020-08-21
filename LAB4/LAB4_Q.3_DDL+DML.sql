
drop table attendance;
drop table course;
drop table student;

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD' ;

create table student(
sroll int primary key,
name varchar(25) not null,
branch varchar(10) not null,
batch varchar(10) not null,
progr varchar(10)
);

create table course(
cid int primary key,
cname varchar(10) not null,
instructor varchar(15) not null
);

create table attendance(
sroll int  not null references student(sroll),
cid int not null references course(cid),
period_s date,
period_e date,
no_of_classes int not null,
attend int not null
);


insert into student values(1,'John','cse','2017','btech');
insert into student values(2,'Smith','cse','2015','mtech');
insert into student values(3,'Jack','mee','2017','btech');
insert into student values(4,'David','eee','2015','btech');
insert into student values(5,'Evans','ece','2017','mtech');

insert into course values(1,'agt','joy');
insert into course values(2,'et','sankarsan');
insert into course values(3,'iem','bartarya');
insert into course values(4,'db','plb');


insert into attendance values(1,1,'2020-01-03','2020-05-06',12,65);
insert into attendance values(1,2,'2020-01-02','2020-05-06',12,67);
insert into attendance values(2,1,'2020-01-01','2020-05-06',12,80);
insert into attendance values(3,3,'2020-01-05','2020-05-06',12,90);
insert into attendance values(4,2,'2020-01-03','2020-05-06',12,65);
insert into attendance values(5,4,'2020-01-03','2020-05-06',12,75);
insert into attendance values(5,3,'2020-01-03','2020-05-06',12,65);


/* 1 - here i am taking course id from user*/
Select student.name from student where student.sroll in (select sroll from attendance where attend<80 and cid=1);
/* 2 -here batch i am takin 2017 */
drop view attendance_sheet;
create view attendance_sheet as (Select sroll,cid,attend from attendance where sroll in(Select sroll from student where batch='2017'));
Select * from attendance_sheet;

/* 3 */
Select name from student where sroll in (select a.sroll from attendance_sheet a where a.attend<70 group by a.sroll having count(*)=(Select count(*) from attendance_sheet e where e.sroll=a.sroll));

/* 4 */
drop view attendance_cid;
Create view attendance_cid as (Select sroll,attend from attendance where cid=3);
Select * from attendance_cid;

/* 5 */
update attendance_cid set attend=attend+5;
Select * from attendance;

/*6*/
drop table ATT_Marks;
create table ATT_Marks(
sroll int,
cid int,
marks int
);
DECLARE 
   marks number; 
   s_roll number; 
   c_id number; 

FUNCTION findmarks(s_roll IN number, c_id IN number)  
RETURN number 
IS 
    z number;
    marks number; 
BEGIN 
  select attend into z from attendance where sroll = s_roll and cid=c_id;
  IF(z>=95) THEN 
  marks:=5;
  ELSIF(z>=85 AND z<95) THEN
  marks:=4;
  ELSIF(z>=75 AND z<85) THEN
  marks:=3;
  ELSIF(z>=60 AND z<75) THEN
  marks:=2;
  ELSIF(z<60) THEN
  marks:=0;
  END IF;

  RETURN marks;

END; 

BEGIN 
   s_roll:= 1; 
   c_id:= 1;  
   marks := findmarks(s_roll, c_id); 
   dbms_output.put_line(' marks for  ' || s_roll ||'  for course_id '||c_id); 
   Insert into ATT_Marks values (s_roll,c_id,marks);
END;
/
Select * from ATT_Marks;
