insert into professor values (13100, '0000', '����ȣ', '��ǻ�Ͱ��а�', 'db@gmail.com');
insert into professor values (13110, '0000', 'ä����', '��ǻ�Ͱ��а�', 'ai@gmail.com');
insert into professor values (13111, '0000', '������', '��ǻ�Ͱ��а�', 'c@gmail.com');
insert into professor values (13112, '0000', '�ڼ���', '��ǻ�Ͱ��а�', 'd@gmail.com');
insert into teach values ('C010', 2, 2019, 2, 13110, 6, 1, '��Ű� 606', 900, 1015);
select * from professor;
insert into COURSE values('C900', 3, 3, '�����ͺ��̽� ���α׷���');
insert into COURSE values('C901', 1, 3, '�ΰ�����');
insert into COURSE values('C899', 1, 3, '�ü��');
select * from course;
delete from course;
delete from professor;
delete from students;
insert into students values(1616613, '0000', '��ö��', '��ǻ�Ͱ��а�', '����', 'gg@gmail.com');
insert into professor values('13100', '0000', '����ȣ', '��ǻ�Ͱ��а�', 'db@gmail.com');
insert into students values('1616612', '2997', '������', '��ǻ�Ͱ��а�', '���� ����',' gakyunggu@gmail.com');
select * from teach t, course c where t.c_id=c.c_id and t.c_no=c.c_no and t.p_id='13100';
select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no