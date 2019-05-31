create or replace PROCEDURE InsertCourse (
  professorID IN VARCHAR2,
  courseName IN VARCHAR2,
  courseDay IN VARCHAR2,
  courseHour IN VARCHAR2,
  courseRoom IN VARCHAR2,
  courseMax IN NUMBER,
  result OUT VARCHAR2)
IS
  duplicate_course EXCEPTION; /*이미 등록한 수업일 경우*/
  not_available_room EXCEPTION; /*해당 장소와 시간에 이미 수업이 등록되어있는 경우*/
  too_many_courses EXCEPTION; /*다른 강의 시간과 겹치는 경우*/
  nYear NUMBER;
  nSemester NUMBER;
  nCnt NUMBER;

  DBMS_OUTPUT.put_line(professorID || '님이 ' || courseName || ' 강좌 등록을 요청하였습니다.');

  select COUNT(*)
  into nCnt
  from course c
  where c.c_name = courseName;

  IF (nCnt > 0) THEN
  RAISE duplicate_course;
  END IF;

  IF 
