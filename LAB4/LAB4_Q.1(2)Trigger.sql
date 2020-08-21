create table account (
    accno number primary key,
    accname varchar2(20) not null,
    type varchar2(10) not null,
    balance number not null
);

create table transaction (
    tr_id number primary key,
    accno number not null,
    tr_type char(1) not null,
    amt number not null,
    trdate date,
    foreign key (accno) references account(accno) on delete cascade
);

insert all
    into account (accno, accname, type, balance) values (1, 'Alice', 'savings', 1000)
    into account (accno, accname, type, balance) values (2, 'Don', 'savings', 45600)
    into account (accno, accname, type, balance) values (3, 'Norman', 'savings', 56612)
    into account (accno, accname, type, balance) values (4, 'King', 'savings', 120)
    into account (accno, accname, type, balance) values (5, 'Peter', 'savings', 8974)
    into account (accno, accname, type, balance) values (6, 'Jeff', 'savings', 1356)
    into account (accno, accname, type, balance) values (7, 'Bob', 'savings', 569)
    into account (accno, accname, type, balance) values (8, 'Martha', 'savings', 233)

select * from account;

create or replace trigger amt_transaction
before insert on transaction
for each row
declare
	cursor acts is
        select * 
        from account;
    
    cursor trns is
        select * 
        from transaction;

    u_amt number;
    u_accno number;
    u_w char(1);

    bal_amt number;
    flag number;
    
begin
	
	flag := 0;

	u_accno := :new.accno;
	u_amt := :new.amt;
	u_w := :new.tr_type;

	for r in acts
	loop
		if r.accno = u_accno then
			bal_amt := r.balance;
			flag := 1;
			exit;
		end if;
	end loop;

	if flag = 0 then
		raise_application_error(-20001, 'Sorry! The account does not exist here!');
	else
		if u_w = 'w' then
			-- withdraw
			if u_amt > bal_amt then
				raise_application_error(-20002, 'Transaction failed! Insufficient balance');
			else
				update account 
                set balance = balance - u_amt
                where accno = u_accno;
                dbms_output.put_line('Transaction successfull! Account data updated');
			end if;
		else
			-- deposit
			update account 
            set balance = balance + u_amt
            where accno = u_accno;
            dbms_output.put_line('Transaction successfull! Account data updated');
		end if;
	end if;

end;
/
declare 
    
    tr_id number;
    u_amt number;
    u_accno number;
    u_w char(1);
    
    
begin

    for tr_id in 1..1
    loop
        -- u_accno := :u_accno;
        -- u_amt := :u_amt;
        -- u_w := :u_w;
        
        u_accno := 1;
        u_amt := 500;
        u_w := 'w';

        insert into transaction
        values (tr_id, u_accno, u_w, u_amt, to_date(sysdate,'yyyy-mm-dd hh24:mi:ss'));

    end loop;
end;
/

select *
from account;

select *
from transaction;
