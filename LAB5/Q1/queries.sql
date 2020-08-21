/*.a.*/
declare
    type accname_and_balance_type
        is table of number
        index by varchar2(20);
    
    -- create the object
    accname_bal accname_and_balance_type;

    cursor accs is
        select *
        from account;
    
    ab_index varchar2(20);
    
    u_accname varchar2(20);
    flag number;

begin
    
    -- create the collection here
    for r in accs
    loop
        accname_bal(r.accname) := r.balance;
    end loop;
    
    -- get user name
    u_accname := '&u_accname';
    
    -- get data
    if accname_bal(u_accname) < 100 then
        dbms_output.put_line('Low account balance!!');
    else
        dbms_output.put_line(u_accname || '''s acc bal is: ' || accname_bal(u_accname));
    end if;    
end;
/



/*.b.*/
declare
    type accname_and_balance_type
        is table of number
        index by varchar2(20);
    
    -- create the object
    accname_bal accname_and_balance_type;

    cursor accs is
        select *
        from account;
    
    ab_index varchar2(20);
    
    u_accname varchar2(20);
    flag number;

begin
    
    -- create the collection here
    for r in accs
    loop
        accname_bal(r.accname) := r.balance;
    end loop;
    
    
    -- get name to delete
    u_accname := 'King';
    flag := 0;
    
    if accname_bal.exists(u_accname) then
        flag := 1;
        accname_bal.delete(u_accname);
    else
        dbms_output.put_line('No such account name exists!');
    end if;
    
    if accname_bal.exists(u_accname) then
        dbms_output.put_line('May be delete operation was unsuccessful!');
    elsif flag = 1 then
        dbms_output.put_line('Delete successful!');
    end if;
    
end;
/


/*.c.*/
declare
    type accname_and_balance_type
        is table of number
        index by varchar2(20);
    
    -- create the object
    accname_bal accname_and_balance_type;

    cursor accs is
        select *
        from account;
    
    ab_index varchar2(20);
    
    u_accname varchar2(20);
    flag number;

begin
    
    -- create the collection here
    for r in accs
    loop
        accname_bal(r.accname) := r.balance;
    end loop;
    
    
    -- get name to delete
    u_accname := 'Alice';
    
    if accname_bal.exists(u_accname) then
        accname_bal(u_accname) := (1.03*accname_bal(u_accname));
        dbms_output.put_line('Update successful in the Array');
        
        update account
            set balance = accname_bal(u_accname)
        where accname = u_accname;
        dbms_output.put_line('Update successful in the Table');
    else
        dbms_output.put_line('No such account name exists!');
    end if;
    
    
end;
/

select *
from account;



/*.d.*/
declare
    type accname_and_balance_type
        is table of number
        index by varchar2(20);
    
    -- create the object
    accname_bal accname_and_balance_type;

    cursor accs is
        select *
        from account;
    
    ab_index varchar2(20);
    
    u_accname varchar2(20);
    flag number;
    counts number;

begin
    
    -- create the collection here
    for r in accs
    loop
        accname_bal(r.accname) := r.balance;
    end loop;
    
    counts := accname_bal.count;
    
    dbms_output.put_line('Total number of accounts in the branch is: ' || counts);
    
    if counts < 100 then
        dbms_output.put_line('Less Customer Branch!!');
    end if;
    
    
end;
/


/*.e.*/
declare
    type accname_and_balance_type
        is table of number
        index by varchar2(20);
    
    -- create the object
    accname_bal accname_and_balance_type;

    cursor accs is
        select *
        from account;
    
    ab_index varchar2(20);
    
    u_accname varchar2(20);
    flag number;
    counts number;

begin
    
    -- create the collection here
    for r in accs
    loop
        accname_bal(r.accname) := r.balance;
    end loop;
    
    ab_index := accname_bal.first;
    
    while ab_index is not null
    loop
        if instr(ab_index, 'th') != 0 then
            dbms_output.put_line('Found: ' || ab_index);
        end if;
        
        ab_index := accname_bal.next(ab_index);
    end loop;
    
    
end;
/





