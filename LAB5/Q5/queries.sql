create or replace view v1 as
    select e.dno, e.eno
    from employee e
    left join (
            select e1.dno, max(e1.salary) salary
            from employee e1
            group by e1.dno
        ) e2 on e.dno = e2.dno
    where e.dno = e2.dno and e.salary = e2.salary;

select * from dept;

update dept d1
    set d1.dmgrno = (select v.eno from v1 v where v.dno = d1.dno)
where exists (select 1 from v1 w where w.dno = d1.dno);


select * from dept;

commit;

insert into dept values (4, 'BioTech', 6);

select * from dept;
rollback;
select * from dept;


/*part 2*/

select dname 
from dept
where dno in (
    select dno
    from employee
    group by dno
    having sum(salary) > 10000000
);