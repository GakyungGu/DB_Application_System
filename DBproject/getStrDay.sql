create or replace function getStrDay(
  courseDay IN NUMBER)
  RETURN VARCHAR2
  IS
  strDay VARCHAR2(10);
BEGIN
  IF (courseDay = 1) THEN
    strDay := '��';
  ELSIF (courseDay = 2) THEN
    strDay := 'ȭ';
  ELSIF (courseDay = 3) THEN
      strDay := '��';
  ELSIF (courseDay = 4) THEN
      strDay := '��';
  ELSIF (courseDay = 5) THEN
      strDay := '��';
  ELSIF (courseDay = 6) THEN
      strDay := '��/��';
  ELSIF (courseDay = 7) THEN
      strDay := 'ȭ/��';
  ELSIF (courseDay = 2) THEN
      strDay := '��';
  ELSE
      strDay := '�˼�����';
  END IF;
  RETURN strDay;
END;
/
