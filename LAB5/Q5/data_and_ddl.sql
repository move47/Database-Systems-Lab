create table employee (
    eno number primary key,
    dno number,
    ename varchar2(20) not null,
    salary number
);

create table dept (
    dno number primary key,
    dname varchar2(20),
    dmgrno number,
    foreign key (dmgrno) references employee(eno) on delete cascade
);


insert all
    into employee (eno, dno, ename, salary) values (1, 1, 'Alice', 1000000)
    into employee (eno, dno, ename, salary) values (2, 1, 'Bob', 8000000)
    into employee (eno, dno, ename, salary) values (3, 1, 'Chris', 3000000)
    into employee (eno, dno, ename, salary) values (4, 1, 'Don', 4000000)
    into employee (eno, dno, ename, salary) values (5, 2, 'Ethen', 1000000)
    into employee (eno, dno, ename, salary) values (6, 2, 'Frik', 1000000)
    into employee (eno, dno, ename, salary) values (7, 2, 'Gomez', 5000000)
    into employee (eno, dno, ename, salary) values (8, 3, 'Hart', 7000000)
    into employee (eno, dno, ename, salary) values (9, 3, 'Izben', 4000000)
    into employee (eno, dno, ename, salary) values (10, 3, 'John', 1000000)

    into dept (dno, dname, dmgrno) values (1, 'R&D', 1)
    into dept (dno, dname, dmgrno) values (2, 'SWE', 7)
    into dept (dno, dname, dmgrno) values (3, 'HR', 8)


select 1 from dual;


select * from employee;
select * from dept;





alter table employee
	add constraint c1 foreign key (dno) references dept(dno) on delete cascade;