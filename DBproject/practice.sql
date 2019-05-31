create or replace PROCEDURE InsertEnroll(
  sStudentId IN VARCHAR2,
  sCourseId IN VARCHAR2,
  nCourseIdNo IN NUMBER,
  result OUT VARCHAR2)
IS
  too_many_sumCourseUnit EXCEPTION;
  too_many_courses EXCEPTION;
  too_many_students EXCEPTION;
  duplicate_time EXCEPTION;
  nYear NUMBER;
  nSemester NUMBER;
  nSumCourseUnit NUMBER;
  nCourseUnit NUMBER;
  nCnt NUMBER;
  nTeachMax NUMBER;
BEGIN
  result := ' ';
  DBMS_OUTPUT.put_line('#');
  DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수강 등록을 요청하였습니다.');

    nYear := DateToEnrollYear(SYSDATE);
    nSemester := DateToEnrollSemester(SYSDATE);

    SELECT SUM(c.c_credit)
    INTO	 nSumCourseUnit
    FROM   course c, enroll e
    WHERE  e.s_id = sStudentId and e.e_year = nYear and e.e_sem = nSemester and  e.c_id = c.c_id and e.c_no = c.c_no;

    SELECT c_credit
    INTO	 nCourseUnit
    FROM	 course
    WHERE	 c_id = sCourseId and c_no = nCourseIdNo;

    IF (nSumCourseUnit + nCourseUnit > 18) THEN
       RAISE too_many_sumCourseUnit;
    ELSE
      nSumCourseUnit := nSumCourseUnit + nCourseUnit;
      DBMS_OUTPUT.put_line('총 학점' || nSumCourseUnit);
    END IF;
  END;
  /
