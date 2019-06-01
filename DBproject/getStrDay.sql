create or replace function getStrDay(
  courseDay IN NUMBER)
  RETURN VARCHAR2
  IS
  strDay VARCHAR2(10);
BEGIN
  IF (courseDay = 1) THEN
    strDay := '월';
  ELSIF (courseDay = 2) THEN
    strDay := '화';
  ELSIF (courseDay = 3) THEN
      strDay := '수';
  ELSIF (courseDay = 4) THEN
      strDay := '목';
  ELSIF (courseDay = 5) THEN
      strDay := '금';
  ELSIF (courseDay = 6) THEN
      strDay := '월/수';
  ELSIF (courseDay = 7) THEN
      strDay := '화/목';
  ELSIF (courseDay = 2) THEN
      strDay := '금';
  ELSE
      strDay := '알수없음';
  END IF;
  RETURN strDay;
END;
/
