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

Select * from Book_stock;
Select * from Book_Issue;
select * from Book_Return;
Select * from Fine;

Create or Replace Trigger insert_issue BEFORE INSERT ON Book_Issue
FOR EACH ROW
DECLARE
already_have_one_book int;
how_many_book int;
no_of_copies int;
BEGIN
Select Count(*) INTO how_many_book from Book_Issue where card_no=:new.card_no; --for Counting the total books user have
Select Count(*) INTO already_have_one_book from Book_Issue where card_no=:new.card_no and book_id=:new.book_id; --for count the no of copies of particualr book
Select no_of_copies INTO no_of_copies from Book_stock where Book_id=:new.book_id;
dbms_output.put_line(:new.card_no|| ' has total books ' || how_many_book||' and already have '||already_have_one_book||' of requested book ');
IF(how_many_book>=3) THEN
raise_application_error(-20001,'Sorry ! You already have 3 books  ');
ELSIF(already_have_one_book>=1) THEN
raise_application_error(-20002,'Sorry ! You already have 1 copy of requested book ');
ELSIF(no_of_copies=0) THEN
raise_application_error(-20003,'Sorry ! No more copies of requested book are available ');
ELSE
Update Book_stock set no_of_copies=no_of_copies-1 where Book_id=:new.Book_id;
dbms_output.put_line('Inserted successfully');
END IF;
END;
/


Create or Replace Trigger insert_iss_ue BEFORE INSERT ON Book_Return
FOR EACH ROW
DECLARE
how_many_book int;
Due_date date;
BEGIN
Select Count(*) INTO how_many_book from Book_Issue where card_no=:new.card_no and book_id=:new.book_id;
Select due_date INTO Due_date from Book_Issue where card_no=:new.card_no and book_id=:new.book_id;--for Counting the total books user have
dbms_output.put_line('user have '||how_many_book);
IF(how_many_book=0) THEN
raise_application_error(-20004,'Sorry ! You haven''t issued this book ');
ELSE
Update Book_stock set no_of_copies=no_of_copies+1 where Book_id=:new.book_id;
Delete from Book_Issue where card_no=:new.card_no and book_id=:new.book_id;
IF(Due_date<SYSDATE) THEN
INSERT into FINE values(:new.card_no,50);
END IF;
END IF;
END;
/




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
choice:='R';
Bo_ok_id:=3;
cholder_name:='Mohit';

IF(choice='I') THEN
INSERT into Book_Issue values(car_d_no,cholder_name,Bo_ok_id,SYSDATE,SYSDATE+30);
ElSIF(choice='R') THEN

Select issue_date INTO Issue_date from Book_Issue where card_no=car_d_no and book_id=Bo_ok_id;
dbms_output.put_line('Returing book issued on '||Issue_date);
Insert Into Book_Return values(car_d_no,cholder_name,Bo_ok_id,SYSDATE,Issue_date);
END IF;
END;
/

Select * from Book_stock;
Select * from Book_Issue;
select * from Book_Return;
Select * from Fine;