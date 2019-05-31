CREATE OR REPLACE PROCEDURE InsertEnroll (
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
  overlap NUMBER;
  CURSOR duplicate_time_cursor IS
    SELECT *
    FROM enroll
    WHERE s_id = sStudentId;
BEGIN
  result := '';

DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || sCourseId || ', �й� ' || TO_CHAR(nCourseIdNo) || '�� ���� ����� ��û�Ͽ����ϴ�.');

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
  END IF;

  SELECT COUNT(*)
  INTO	 nCnt
  FROM   enroll
  WHERE  s_id = sStudentId and c_id = sCourseId;

  IF (nCnt > 0) THEN
     RAISE too_many_courses;
  END IF;

  SELECT t_max
  INTO	 nTeachMax
  FROM   teach
  WHERE  t_year= nYear and t_sem = nSemester and c_id = sCourseId and c_no= nCourseIdNo;

  SELECT COUNT(*)
  INTO   nCnt
  FROM   enroll
  WHERE  e_year = nYear and e_sem = nSemester and c_id = sCourseId and c_no = nCourseIdNo;

  IF (nCnt >= nTeachMax)
  THEN
     RAISE too_many_students;
  END IF;

  INSERT INTO enroll(s_id,c_id,c_no,e_year,e_sem) VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);

  COMMIT;
  result := '������û ����� �Ϸ�Ǿ����ϴ�.';

EXCEPTION
  WHEN too_many_sumCourseUnit THEN
    result := '�ִ������� �ʰ��Ͽ����ϴ�';
  WHEN too_many_courses THEN
    result := '�̹� ��ϵǾ��ִ� �����Դϴ�.';
  WHEN too_many_students THEN
    result := '������û �ο��� �ʰ��Ǿ� ����� �Ұ����մϴ�';
  WHEN duplicate_time THEN
    result := '�̹� ��ϵ� ���� �� �ߺ��Ǵ� �ð��� �����մϴ�';
  WHEN no_data_found THEN
    result := '�̹� �б� ������ �ƴմϴ�.';
  WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/
