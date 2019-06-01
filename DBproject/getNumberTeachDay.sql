create or replace function getNumberTeachDay(
  courseDay IN VARCHAR2)
  RETURN number
  IS
  mon NUMBER;
  tue NUMBER;
  wed NUMBER;
  thu NUMBER;
  fri NUMBER;
  nCourseDay NUMBER;
BEGIN
  /* t_day number(1) */
  /* 1 : mon, 2 : tue, 3 : wed, 4 : thu, 5 : fri */
  /* 6 : mon & wed, 7 : tue & thu, 8 : wed & fri */
  mon := INSTR(courseDay, '1');
  tue := INSTR(courseDay, '2');
  wed := INSTR(courseDay, '3');
  thu := INSTR(courseDay, '4');
  fri := INSTR(courseDay, '5');
  nCourseDay := 0;

  IF (mon > 0 and tue = 0 and wed = 0 and thu = 0 and fri = 0) THEN
    nCourseDay := 1;
  ELSIF (mon = 0 and tue > 0 and wed = 0 and thu = 0 and fri = 0) THEN
    nCourseDay := 2;
  ELSIF (mon = 0 and tue = 0 and wed > 0 and thu = 0 and fri = 0) THEN
    nCourseDay := 3;
  ELSIF (mon = 0 and tue = 0 and wed = 0 and thu > 0 and fri = 0) THEN
    nCourseDay := 4;
  ELSIF (mon = 0 and tue = 0 and wed = 0 and thu = 0 and fri > 0) THEN
    nCourseDay := 5;
  ELSIF (mon > 0 and tue = 0 and wed > 0 and thu = 0 and fri = 0) THEN
    nCourseDay := 6;
  ELSIF (mon = 0 and tue > 0 and wed = 0 and thu > 0 and fri = 0) THEN
    nCourseDay := 7;
  ELSIF (mon = 0 and tue = 0 and wed > 0 and thu = 0 and fri > 0) THEN
    nCourseDay := 8;
  ELSE
    nCourseDay := 9;
  END IF;

  RETURN nCourseDay;
END;
/
