CREATE OR REPLACE FUNCTION DateToEnrollYear(dDate IN DATE)
	RETURN NUMBER
	IS
		year enroll.e_year%TYPE;
	BEGIN
		year := TO_CHAR(DATE, 'yyyy');
		RETURN year;
	END;
/
