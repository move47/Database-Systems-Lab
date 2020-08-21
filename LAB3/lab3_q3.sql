
drop table Book_stock;
drop table Book_Issue;
drop table Book_Return;

Create table Book_stock
(
Book_id int PRIMARY KEY,
Title varchar(50) NOT NULL,
no_of_copies int
);

Create table Book_Issue
(
card_no int,
cholder_name varchar(50) NOT NULL,
book_id int,
issue_date date,
due_date date,
FOREIGN KEY(book_id) REFERENCES Book_stock(Book_id) ON DELETE CASCADE
);

Create table Book_Return(
card_no int,
cholder_name varchar(50) NOT NULL,
book_id int,
return_date date,
issue_date date,
FOREIGN KEY(book_id)REFERENCES Book_stock(Book_id) ON DELETE CASCADE
);
Create table FINE(
card_no int,
fine_amt int
);

Insert into Book_stock values(1,'Math',20);
Insert into Book_stock values(2,'English',15);
Insert into Book_stock values(3,'Hindi',50);
Insert into Book_stock values(4,'Sanskrit',16);
Insert into Book_stock values(5,'Informatics Practices',10);


DECLARE
car_d_no int;
choice char(1);
Bo_ok_id int;
no_of_books_user_already_have int;
Issue_date date;
Due_date date;
flag int:=0;
cholder_name varchar(20);
no_of_copies_available_for_particulat_book int:=0;
BEGIN
car_d_no:=1002;
choice:='I';
Bo_ok_id:=3;
cholder_name:='Mohit';

Select Count(*) INTO no_of_books_user_already_have from Book_Issue where card_no=car_d_no; --for Counting the total books user have
Select Count(*) INTO flag from Book_Issue where card_no=car_d_no and book_id=Bo_ok_id; --for count the no of copies of particualr book
Select no_of_copies INTO no_of_copies_available_for_particulat_book from Book_stock where Book_id=Bo_ok_id; --No of copies

IF(flag=1) THEN
dbms_output.put_line('User already have one copy the requested book');
ELSIF(no_of_books_user_already_have=3) THEN
dbms_output.put_line('User already have 3 books');
END IF;

IF(choice='I' AND no_of_books_user_already_have<3 AND flag!=1 AND no_of_copies_available_for_particulat_book>=1) THEN
Update Book_stock set no_of_copies=no_of_copies-1 where Book_id=Bo_ok_id; 
INSERT into Book_Issue values(car_d_no,cholder_name,Bo_ok_id,SYSDATE,SYSDATE+30);
ElSIF(choice='R') THEN
Update Book_stock set no_of_copies=no_of_copies+1 where Book_id=Bo_ok_id;
Select issue_date,due_date INTO Issue_date,Due_date from Book_Issue where card_no=car_d_no and book_id=Bo_ok_id;
Insert Into Book_Return values(car_d_no,cholder_name,Bo_ok_id,SYSDATE,Issue_date);
IF(Due_date<SYSDATE) THEN
INSERT into FINE values(car_d_no,50);
END IF;
END IF;
END;

Select * from Book_stock;
Select * from Book_Issue;
select * from Book_Return;
Select * from Fine;

