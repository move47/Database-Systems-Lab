drop table transaction;
create table transaction(
transno int PRIMARY KEY,
acctno int,
transdate date,
amount int
);

INSERT into transaction values (1,123456,to_date('2019-10-11', 'yyyy-mm-dd'),100);
INSERT into transaction values (2,234567,to_date('2019-10-11', 'yyyy-mm-dd'),100);
INSERT into transaction values (3,123456,to_date('2019-10-12', 'yyyy-mm-dd'),-50);
INSERT into transaction values (4,345678,to_date('2019-10-12', 'yyyy-mm-dd'),200);
INSERT into transaction values (5,234567,to_date('2019-10-12', 'yyyy-mm-dd'),500);
INSERT into transaction values (6,123456,to_date('2019-10-13', 'yyyy-mm-dd'),300);
INSERT into transaction values (7,345678,to_date('2019-10-13', 'yyyy-mm-dd'),-40);
INSERT into transaction values (8,234567,to_date('2019-10-13', 'yyyy-mm-dd'),-70);
DROP VIEW TP;
CREATE VIEW TP As Select T1.acctno,T1.transdate,T2.amount from transaction T1,transaction T2 
					where T1.acctno=T2.acctno and T1.transdate>=T2.transdate;

Select * from TP;
Drop view TP2;
Create VIEW TP2 AS Select T1.acctno,T1.transdate,(Select SUM(T2.amount) from TP T2 where T1.acctno=T2.acctno and T1.transdate=T2.transdate) amt from transaction T1;
Select * from TP2;
Select acctno,MIN(amt) from TP2 group by acctno;
