create table patient (
	patient_id number primary key,
	patient_name varchar2(20) not null,
	dob date,
	sex char(1) not null
);

create table doctor (
	doctor_id number primary key,
	doctor_name varchar2(20) not null,
	specialization varchar2(20) not null,
	unit number
);	

create table opd_schedule (
	doctor_id number,
	opd_date date,
	opd_time date,
	fees number,
	foreign key (doctor_id) references doctor(doctor_id) on delete cascade
);

create table appointment (
	appointment_no number primary key,
	patient_id number,
	doctor_id number,
	appt_date date,
	foreign key (patient_id) references patient(patient_id) on delete cascade,
	foreign key (doctor_id) references doctor(doctor_id) on delete cascade
);

create table opd_payments (
	appointment_no number,
	patient_id number,
	amount number,
	date_payment date,
	foreign key (appointment_no) references appointment(appointment_no) on delete cascade,
	foreign key (patient_id) references patient(patient_id) on delete cascade
);


-- insert all
	insert into patient (patient_id, patient_name, dob, sex) values (1, 'Ajay', to_date('1980-05-01', 'YYYY-MM-DD'), 'M');
	insert into patient (patient_id, patient_name, dob, sex) values (2, 'Aman', to_date('1981-04-08', 'YYYY-MM-DD'), 'M');
	insert into patient (patient_id, patient_name, dob, sex) values (3, 'Abdul', to_date('1980-05-26', 'YYYY-MM-DD'), 'M');
	insert into patient (patient_id, patient_name, dob, sex) values (4, 'Meena', to_date('1980-11-22', 'YYYY-MM-DD'), 'F');
	insert into patient (patient_id, patient_name, dob, sex) values (5, 'Jaya', to_date('1970-10-10', 'YYYY-MM-DD'), 'F');
	insert into patient (patient_id, patient_name, dob, sex) values (6, 'Rekha', to_date('1959-12-30', 'YYYY-MM-DD'), 'F');
	insert into patient (patient_id, patient_name, dob, sex) values (7, 'Ram', to_date('1969-03-15', 'YYYY-MM-DD'), 'M');
	insert into patient (patient_id, patient_name, dob, sex) values (8, 'Daya', to_date('1960-08-30', 'YYYY-MM-DD'), 'F');

	insert into doctor (doctor_id, doctor_name, specialization, unit) values (1, 'Ross', 'Surgery', 4);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (2, 'Maya', 'Cardio', 4);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (3, 'Dev', 'Neural', 4);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (4, 'Laya', 'Psychiatric', 8);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (5, 'Matt', 'Gastro', 8);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (6, 'Boris', 'Surgery', 6);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (7, 'Kiran', 'Urology', 3);
	insert into doctor (doctor_id, doctor_name, specialization, unit) values (8, 'Mark', 'Surgery', 3);

	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (1, to_date('2019-10-01', 'YYYY-MM-DD'), to_date('10:00', 'HH24:MI'), 2000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (1, to_date('2019-10-16', 'YYYY-MM-DD'), to_date('10:00', 'HH24:MI'), 2000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (2, to_date('2019-10-02', 'YYYY-MM-DD'), to_date('11:00', 'HH24:MI'), 10000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (2, to_date('2019-10-31', 'YYYY-MM-DD'), to_date('21:00', 'HH24:MI'), 10000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (3, to_date('2019-10-05', 'YYYY-MM-DD'), to_date('13:00', 'HH24:MI'), 5000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (3, to_date('2019-10-20', 'YYYY-MM-DD'), to_date('10:00', 'HH24:MI'), 5000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (4, to_date('2019-10-08', 'YYYY-MM-DD'), to_date('18:00', 'HH24:MI'), 20000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (4, to_date('2019-10-12', 'YYYY-MM-DD'), to_date('18:00', 'HH24:MI'), 20000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (3, to_date('2019-10-25', 'YYYY-MM-DD'), to_date('06:00', 'HH24:MI'), 20000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (5, to_date('2019-10-01', 'YYYY-MM-DD'), to_date('08:00', 'HH24:MI'), 2500);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (5, to_date('2019-10-10', 'YYYY-MM-DD'), to_date('19:00', 'HH24:MI'), 25000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (6, to_date('2019-10-07', 'YYYY-MM-DD'), to_date('15:00', 'HH24:MI'), 9000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (6, to_date('2019-10-14', 'YYYY-MM-DD'), to_date('01:00', 'HH24:MI'), 9000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (7, to_date('2019-10-10', 'YYYY-MM-DD'), to_date('16:00', 'HH24:MI'), 77000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (7, to_date('2019-10-30', 'YYYY-MM-DD'), to_date('10:00', 'HH24:MI'), 77000);
	insert into opd_schedule (doctor_id, opd_date, opd_time, fees) values (8, to_date('2019-10-10', 'YYYY-MM-DD'), to_date('10:00', 'HH24:MI'), 100000);

	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (1, 1, 1, to_date('2019-10-01', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (2, 1, 1, to_date('2019-10-16', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (3, 1, 1, to_date('2019-10-16', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (4, 2, 3, to_date('2019-10-05', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (5, 2, 3, to_date('2019-10-20', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (6, 3, 5, to_date('2019-10-10', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (7, 4, 4, to_date('2019-10-08', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (8, 4, 6, to_date('2019-10-14', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (9, 5, 5, to_date('2019-10-01', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (10, 5, 5, to_date('2019-10-10', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (11, 5, 5, to_date('2019-10-10', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (12, 6, 4, to_date('2019-10-08', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (13, 6, 4, to_date('2019-10-08', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (14, 6, 4, to_date('2019-10-12', 'YYYY-MM-DD'));
	insert into appointment (appointment_no, patient_id, doctor_id, appt_date) values (15, 6, 4, to_date('2019-10-12', 'YYYY-MM-DD'));


	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (1, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (2, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (3, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (4, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (5, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (6, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (7, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (8, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (9, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (1, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (1, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))
	-- insert into opd_payments (appointment_no, patient_id, amount, date_payment) values (1, 1, 2000, to_date('2020-01-10', 'YYYY-MM-DD'))





select * from patient;
select * from doctor;
select * from opd_schedule;
select * from appointment;
select * from opd_payments;

-- i.
select patient_name
from patient
where patient_id in (
    select patient_id
    from (
        select doctor_id, patient_id, count(*) as meets
        from appointment
        where appt_date >= to_date('2019-10-01', 'YYYY-MM-DD') and appt_date <= to_date('2019-10-14', 'YYYY-MM-DD')
        group by (doctor_id, patient_id)
    ) where meets > 2
);


-- ii.
declare 
	cursor apmts is
		select * 
		from appointment;

	cursor schedules is
		select *
		from opd_schedule;

	cursor pats is
		select *
		from patient;

	cursor opd_pays is
		select *
		from opd_payments;

	age number;
	gen char(1);
	that_pid number;
	doc_fees number;
	flag number;

begin
	
	for r in apmts
	loop
		select round((sysdate - dob)/365.25, 5) into age
		from patient
		where patient_id = r.patient_id;

		select sex into gen
		from patient
		where patient_id = r.patient_id;

-- 		select unique fees into doc_fees
-- 		from opd_schedule
-- 		where doctor_id = r.doctor_id;
		
		for sch in schedules
		loop 
		    if sch.doctor_id = r.doctor_id then
		        doc_fees := sch.fees;
		        exit;
		    end if;
		end loop;

		flag := 0;
		for pays in opd_pays
		loop
			if pays.patient_id = r.patient_id and (r.appt_date <= (pays.date_payment + 7)) then
				flag := 1;
			end if;
		end loop;

		if  flag = 1 then
			insert into opd_payments
			values (r.appointment_no, r.patient_id, 0, sysdate);
		elsif age >= 50 and gen = 'F' then
			insert into opd_payments
			values (r.appointment_no, r.patient_id, (doc_fees/2), sysdate);
		else
			insert into opd_payments
			values (r.appointment_no, r.patient_id, doc_fees, sysdate);
		end if;
	end loop;
end;
/
select * from opd_payments;



-- iii.

select doctor_id, unit, count(*) as no_of_patients
from (
    select unique a.patient_id, a.doctor_id, d.unit
    from appointment a
    left join doctor d on a.doctor_id = d.doctor_id 
) group by doctor_id, unit;


-- iv.
create or replace view handle_opd_schedule as
    select *
    from opd_schedule;

select * from handle_opd_schedule;

update handle_opd_schedule
	set opd_date = to_date('2020-05-03', 'YYYY-MM-DD'),
		opd_time = to_date('20:00', 'HH24:MI')
where doctor_id = 8;



-- v.
-- https://www.foxinfotech.in/2018/09/how-to-create-log-file-in-oracle-using-pl-sql.html
declare
	cursor apmts is
		select * 
		from appointment;

	cursor schedules is
		select *
		from opd_schedule;

	cursor pats is
		select *
		from patient;

	cursor docs is
		select *
		from doctor;

	pname varchar2(20);
	dname varchar2(20);
	age number;

begin
	dbms_output.put_line('Patient' || chr(9) || 'Age' || chr(9) || 'date_of_visit' || chr(9) || 'doctor_name');
	for r in apmts
	loop
		select patient_name into pname
		from patient
		where patient_id = r.patient_id;

		select round((sysdate - dob)/365.25) into age
		from patient
		where patient_id = r.patient_id;

		select doctor_name into dname
		from doctor
		where doctor_id = r.doctor_id;

		dbms_output.put_line(pname || chr(9) || age || chr(9) || r.appt_date || chr(9) || dname);
	end loop;
end;




-- vi.
create or replace view handle_opd_schedule as
    select *
    from opd_schedule;
    
select * from handle_opd_schedule;

update handle_opd_schedule
	set fees = 4000		
where doctor_id = 5;
