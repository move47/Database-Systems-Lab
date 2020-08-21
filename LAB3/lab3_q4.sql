drop table graph;
Create table graph
(
start_vertex int,
end_vertex int,
weight int
);

Insert into graph values(1,2,5);
Insert into graph values(2,5,2);
Insert into graph values(5,1,1);
Insert into graph values(1,4,5);
Insert into graph values(3,4,2);
Insert into graph values(3,2,11);
Insert into graph values(4,2,6);
Insert into graph values(1,3,9);

Declare
s_vertex graph.start_vertex%type;
e_vertex graph.end_vertex%type;
weigh_t graph.weight%type;
maxdegree int;
mindegree int;
count int;
cursor grap_h_max IS (Select start_vertex,count(*) As "count" from graph group by start_vertex);
cursor grap_h_min IS (Select end_vertex,count(*) AS "count" from graph group by end_vertex);
cursor paths IS (select g1.start_vertex,g2.end_vertex,g1.weight+g2.weight from graph g1,graph g2 where g1.end_vertex=g2.start_vertex and g1.weight+g2.weight<10);
count1 int;
BEGIN
Select Max(count(*)) into maxdegree from graph group by start_vertex;
Select Min(count(*)) into mindegree from graph group by end_vertex;
dbms_output.put_line('Maximum Degree Vertices');
OPEN grap_h_max;
LOOP 
FETCH grap_h_max INTO s_vertex,count1;
    EXIT WHEN grap_h_max%NOTFOUND;
    IF(count1=maxdegree) THEN
    dbms_output.put_line(s_vertex);
    END IF;
    END LOOP;
CLOSE grap_h_max;
dbms_output.put_line('Minimum Degree Vertices');
OPEN grap_h_min;
LOOP 
FETCH grap_h_min INTO e_vertex,count1;
    EXIT WHEN grap_h_min%NOTFOUND;
    IF(count1=mindegree) THEN
    dbms_output.put_line(e_vertex);
    END IF;
    END LOOP;
CLOSE grap_h_min;
dbms_output.put_line('Path of length 2 having sum of weights less than 10');
OPEN paths;
LOOP 
FETCH paths INTO s_vertex,e_vertex,count1;
    EXIT WHEN paths%NOTFOUND;
    dbms_output.put_line(s_vertex||' '||e_vertex||'  '||'weight-'||count1);
    END LOOP;
CLOSE paths;
END;


