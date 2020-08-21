/*Q - 5*/
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
select 1 from dual;

select * from account;
