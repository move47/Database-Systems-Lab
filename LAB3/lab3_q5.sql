drop table account;
drop table transaction;

Create table account(
	accno int not null primary key,
	accname varchar(20) not null,
	type varchar(20) not null,
	balance int not null
	);

insert into account values(12345,'Max'  ,'savings',10000 );
insert into account values(23456,'Duke'   ,'savings',30000);
insert into account values(34567,'James' ,'savings',40000);
insert into account values(45678,'Smith','savings',200);
insert into account values(56789,'simon' ,'savings',50 );


Create table transaction(
	tid int not null primary key,
	accno int not null references account(accno),
	type varchar(20) ,
	amount int not null ,
	tdate date
	);
	
Select * from account;

--creating a sequence for transaction id's
CREATE SEQUENCE trans_no
  MAXVALUE 10000
  START WITH 1000
  INCREMENT BY 1
  CACHE 20;


DECLARE
id int;
amt int;
acn int;
blnc account.balance%type;
opt varchar(1);

BEGIN
acn := 45678;
amt :=300 ;
opt :='w';

if (opt='w') then
	select balance into blnc from account where accno = acn;
	if (amt<blnc) then --chacking wheather user have sufficient balance for processing withdrawal request
		update account set balance=balance-amt where accno=acn;
		insert into transaction values(trans_no.nextval,acn,opt,amt,SYSDATE);
			dbms_output.put_line('amount debited from  '||acn);
	else 
		dbms_output.put_line('insufficient balance.');
	end if;
elsif(opt='d') then --if deposit directly add it to balance
		update account set balance = balance+amt where accno=acn;
			dbms_output.put_line('amount credited into  '||acn);
insert into transaction values(trans_no.nextval,acn,opt,amt,SYSDATE);

end if;
end;

Select * from account;
Select * from transaction;