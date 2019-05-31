create or replace function createCourseId
  RETURN VARCHAR2
  IS
    courseId course.c_id%TYPE;
    nCourseId course.c_id%TYPE;
    nCnt NUMBER;
  BEGIN
    select COUNT(*)
    into nCnt
    from course;

    select LPAD(TO_CHAR(nCnt), 3, '0')
    into courseId
    from dual;

    courseId := 'C' || courseId;
    RETURN courseId;
  END;
  /
