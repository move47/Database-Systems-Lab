CREATE table student(
  name varchar(15),
  student_number int PRIMARY KEY,
  class int,
  major char(5)
  );
 CREATE table course(
  course_name varchar(50),
  course_number  varchar(15) PRIMARY KEY,
  credit_hours int,
  department char(5)
  );
  
 CREATE table section(
  section_identifier int PRIMARY KEY,
  course_number varchar(15),
  semester char(10),
  y_ear int,
  instructor char(15),
  FOREIGN KEY(course_number) REFERENCES course(course_number) ON DELETE CASCADE
  );
  
 CREATE table grade_report(
  student_number int,
  section_identifier int,
  grade char(5),
  FOREIGN KEY(student_number) REFERENCES student(student_number) ON DELETE CASCADE,
    FOREIGN KEY(section_identifier) REFERENCES section(section_identifier) ON DELETE CASCADE
  );

CREATE table prerequisite(
  course_number varchar(10),
  prerequisite_number varchar(10), 
  FOREIGN KEY(course_number) REFERENCES course(course_number) ON DELETE CASCADE, 
  FOREIGN KEY(prerequisite_number) REFERENCES course(course_number) ON DELETE CASCADE
  );
  
Insert into student values('Smith',17,1,'CS');
Insert into student values('Brown',8,2,'CS');
Insert into student values('JOHN',10,3,'MATH');
Insert into student values('JACK',15,4,'MATH');

Insert into course values('Intro to Computer Science ','CS1310',4,'CS');
Insert into course values('Data Structures ','CS3320',4,'CS');
Insert into course values('Discrete Mathematics ','MATH2410',3,'MATH');
Insert into course values('Database ','CS3380',3,'CS');

Insert into section values('85','MATH2410','Fall',07,'King');
Insert into section values('92','CS1310','Fall',07,'Anderson');
Insert into section values('102','CS3320','Spring',08,'Knuth');
Insert into section values('112','MATH2410','Spring',08,'Chang');
Insert into section values('119','CS1310','Fall',08,'Anderson');
Insert into section values('135','CS3380','Fall',08,'Stone');

Insert into grade_report values(17,'112','B');
Insert into grade_report values(17,'119','C');
Insert into grade_report values(8,'85','A');
Insert into grade_report values(8,'92','A');
Insert into grade_report values(8,'102','B');
Insert into grade_report values(8,'135','A');
Insert into grade_report values(10,'85','F');
Insert into grade_report values(10,'135','F');
Insert into grade_report values(10,'119','F');
Insert into grade_report values(15,'112','F');
Insert into grade_report values(15,'135','C');

Insert into prerequisite values('CS3380','CS3320');
Insert into prerequisite values('CS3380','MATH2410');
Insert into prerequisite values('CS3320','CS1310');
  
  



select s.name as student_name,sec.course_number,sec.semester,sec.y_ear,sec.section_identifier as section_id,g.grade from student s,section sec,grade_report g
where g.student_number=s.student_number and g.section_identifier = sec.section_identifier;

select s.name from student s where s.student_number in(select g.student_number from grade_report g where g.grade='A');

select sec.course_number,Count(*) as no_of_students_in_course from section sec,grade_report g where sec.section_identifier=g.section_identifier group by
sec.course_number;

select s.name from student s where s.student_number in(select g.student_number from grade_report g where g.section_identifier=all(select sec.section_identifier from section sec
	where sec.instructor='Anderson'));

select g.student_number,SUM(c.credit_hours),s.y_ear from section s,grade_report g,course c where g.section_identifier=s.section_identifier and c.course_number=s.course_number group by s.y_ear,g.student_number;

select s.name from student s where s.student_number in (select g.student_number from course c,section sec,grade_report g where sec.section_identifier=g.section_identifier and c.course_number=sec.course_number group by g.student_number,c.department having c.department='CS' and count(*)>=2
INTERSECT
select g.student_number from course c,section sec,grade_report g where sec.section_identifier=g.section_identifier and c.course_number=sec.course_number group by g.student_number,c.department having c.department='MATH' and count(*)>=1);

Delete from course where course_number='MATH2410';

select name from student where student_number=(select g.student_number from grade_report g ,section s
where g.section_identifier = s.section_identifier
and g.grade='F' group by s.semester,g.student_number having count(*)>1);



update grade_report
SET grade =(CASE 
            WHEN grade='A' THEN '10'
            WHEN grade='B' THEN '9'
            WHEN grade='C' THEN '8'
            WHEN grade='D' THEN '7'
            WHEN grade='P' THEN '6'
            WHEN grade='F' THEN '5'
            END);