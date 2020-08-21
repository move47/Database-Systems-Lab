declare 
    type assoc_arr
        is table of number
        index by pls_integer;

    type nested_simple is table of number;

    mycol nested_simple;
    idx number;
    sz number;

    v1 assoc_arr;
    idx2 number;
    
    
    -- excps
    e1 exception;
    e2 exception;
    e3 exception;
    e4 exception;
    
    
begin
    
    
    
    -- nested array here
    
    mycol := nested_simple(500, 231, 450, 0, 100, 50, 9000);
    
    dbms_output.put_line('size before extend: ' || mycol.count);
    mycol.extend(5);
    dbms_output.put_line('size after extend: ' || mycol.count);
    
    -- associated array here
    
    -- to test exception
    
    v1(1) := 200;
    v1(2) := 100;
    v1(3) := 0;
    v1(4) := 10;
    v1(5) := 960;
    v1(6) := 270;
    v1(7) := 360;
    v1(8) := 5000;
    
    -- to test exception
    v1(9) := 'string';
    -- to test exception
    -- dbms_output.put_line(v1(10));
    
    
    
    
    
    idx2 := v1.first;
    
    while idx2 is not null
    loop
        dbms_output.put_line('idx2: ' || idx2 || ' and val: ' || v1(idx2));
        idx2 := v1.next(idx2);
    end loop;
    
    dbms_output.put_line('size before delete: ' || v1.count);
    v1.delete(4);
    dbms_output.put_line('size after delete: ' || v1.count);

exception
    when no_data_found then
    --     raise e1;
    -- when e1 then
        dbms_output.put_line('No data found!');
    
    when collection_is_null then
    --     raise e2;
    -- when e2 then
        dbms_output.put_line('The colllection is null still. Please enter some data into it!');

    when value_error then
    --     raise e3;
    -- when e3 then
        dbms_output.put_line('Key value error has occured!');

    when subscript_beyond_count then
    --     raise e4;
    -- when e4 then
        dbms_output.put_line('Index out of bounds!');

end;


    -- for idx in 1 .. sz
    -- loop
    --     dbms_output.put_line('for idx: ' || idx || ' val: ' || mycol(idx));
    -- end loop;


