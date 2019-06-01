create table enroll (
c_id VARCHAR2(4),
c_no number(2),
e_year number(4),
e_semi number(1),
s_id number(10), 
constraints enroll_pk primary key(c_id, e_year, e_semi, s_id),
constraints enroll_fk1 foreign key(s_id) references students(s_id),
constraints enroll_fk2 foreign key(c_id, c_no, e_year, e_semi) references teach(c_id, c_no, t_year, t_sem) on delete cascade
constraints enroll_fk3 foreign key(c_id, c_no) references course(c_id, c_no) on delete cascade;
);

create table teach (
c_id  VARCHAR(4),
c_no NUMBER(2), 
t_year NUMBER(4),
t_sem NUMBER(1),
p_id NUMBER(10),
T_hour NUMBER(2),
T_day NUMBER(1),
T_max NUMBER(3),
T_room VARCHAR(20),
constraints teach_pk primary key(c_id, c_no, t_year, t_sem),
constraints teach_fk foreign key(p_id) references professor(p_id),
constraints teack_fk2 foreign key(c_id, c_no) references course(c_id, c_no) on delete cascade
);

create table course(
c_id VARCHAR2(4),
c_no NUMBER(2),
c_credit NUMBER(1),
c_name VARCHAR(30),
constraints course_pk primary key(c_id, c_no));