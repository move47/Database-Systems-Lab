declare
    type nst_arr
        is table of number;
    
    v1 nst_arr;
        
begin 
    dbms_output.put_line('the date is: ' || to_date(sysdate, 'DD-MM-YYYY'));
    dbms_output.put_line('testig to_char as: ' || to_char(12.56, '$99.99'));
    dbms_output.put_line('using lpad on string Zach as ' || lpad('Zach', 8, '1'));
    
    v1 := nst_arr(1, 76, 34, 56, 21, 70);
    dbms_output.put_line('size before trim: ' || v1.count);
    v1.trim(4);
    dbms_output.put_line('size after trim: ' || v1.count);
    
    
end;