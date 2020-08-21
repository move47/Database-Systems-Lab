/*.a.*/
declare 
    invalid_data exception;
    
    cursor students is
        select *
        from student;
    
    u_sname varchar2(20);
    s_branch varchar(10);
    s_cgpa number(4, 2);
    
begin

    -- u_sname := '&u_sname';
    u_sname := 'Missy';
    
    select branch, cgpa into s_branch, s_cgpa
    from student
    where sname = u_sname;

    dbms_output.put_line(u_sname || '''s branch: ' || s_branch || ' and cgpa: ' || s_cgpa);

exception
    
    when no_data_found then
        dbms_output.put_line('No such student exists!');
    
end;




/*.b.*/
select s.sname
from student s
where s.branch = 'cse' and cgpa = (
    select mxcgpa
    from (
        select branch, max(cgpa) mxcgpa
        from student
        group by branch   
    )
    where branch = s.branch 
);


/*.c.*/
declare 
    less_data exception;
    
    cursor students is
        select *
        from student;
    
    u_sname varchar2(20);
    s_branch varchar(10);
    s_cgpa number(4, 2);
    tot_records number;
    
begin

    select count(*) into tot_records
    from student;

    if tot_records < 5 then
        raise less_data;
    end if;

    dbms_output.put_line('Total records in the student table: ' || tot_records);

exception
    
    when less_data then
        dbms_output.put_line('less populated table');
    
end;
/


/*.d.*/
select *
from student
where gender = 'F' and branch = 'cse';







