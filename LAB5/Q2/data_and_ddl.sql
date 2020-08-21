/*Q - 2*/
create table student (
    sroll number primary key,
    sname varchar2(20) not null,
    branch varchar2(10) not null,
    gender char(1) not null,
    cgpa number(4, 2)
);

insert all
    into student (sroll, sname, branch, gender, cgpa) values (1, 'Ross', 'cse', 'M', 9.3)
    into student (sroll, sname, branch, gender, cgpa) values (2, 'Dona', 'cse', 'F', 9.6)
    into student (sroll, sname, branch, gender, cgpa) values (3, 'Norman', 'ece', 'M', 9.2)
    into student (sroll, sname, branch, gender, cgpa) values (4, 'Missy', 'ece', 'F', 8.5)
    into student (sroll, sname, branch, gender, cgpa) values (5, 'Peter', 'me', 'M', 7.5)
    into student (sroll, sname, branch, gender, cgpa) values (6, 'Monica', 'me', 'F', 8.8)
    into student (sroll, sname, branch, gender, cgpa) values (7, 'Bob', 'ee', 'M', 9.9)
    into student (sroll, sname, branch, gender, cgpa) values (8, 'Martha', 'ee', 'F', 8.1)
    into student (sroll, sname, branch, gender, cgpa) values (9, 'John', 'cse', 'M', 9.6);
select 1 from dual;

select * from student;
