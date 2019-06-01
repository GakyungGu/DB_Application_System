declare
	result varchar2(50);
begin
	InsertEnroll('1616612', 'C900', 3, result);
	dbms_output.put_line(result);
end;
/