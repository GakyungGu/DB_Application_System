insert into professor values (13100, '0000', '심준호', '컴퓨터과학과', 'db@gmail.com');
insert into professor values (13110, '0000', '채희준', '컴퓨터과학과', 'ai@gmail.com');
insert into professor values (13111, '0000', '유석종', '컴퓨터과학과', 'c@gmail.com');
insert into professor values (13112, '0000', '박숙영', '컴퓨터과학과', 'd@gmail.com');
insert into teach values ('C010', 2, 2019, 2, 13110, 6, 1, '명신관 606', 900, 1015);
select * from professor;
insert into COURSE values('C900', 3, 3, '데이터베이스 프로그래밍');
insert into COURSE values('C901', 1, 3, '인공지능');
insert into COURSE values('C899', 1, 3, '운영체제');
select * from course;
delete from course;
delete from professor;
delete from students;
insert into students values(1616613, '0000', '김철수', '컴퓨터과학과', '서울', 'gg@gmail.com');
insert into professor values('13100', '0000', '심준호', '컴퓨터과학과', 'db@gmail.com');
insert into students values('1616612', '2997', '구가경', '컴퓨터과학과', '용인 수지',' gakyunggu@gmail.com');
select * from teach t, course c where t.c_id=c.c_id and t.c_no=c.c_no and t.p_id='13100';
select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no