use Lab5;
/*
CREATE Table AUDITORIUM_TYPE
(AUDITORIUM_TYPE char(10) NOT NULL constraint PK_AUDITORIUM_TYPE primary key(AUDITORIUM_TYPE),
AUDITORIUM_TYPENAME varchar(30) NULL);
CREATE Table AUDITORIUM
(AUDITORIUM char(20) NOT NULL constraint PK_AUDITORIUM primary key(AUDITORIUM),
AUDITORIUM_TYPE char(10) NOT NULL constraint FK_AUDITORIUM_AUDITORIUM_TYPE foreign key(AUDITORIUM_TYPE) references AUDITORIUM_TYPE(AUDITORIUM_TYPE),
AUDITORIUM_CAPACITY int default 1 check(AUDITORIUM_CAPACITY between 1 and 300),
AUDITORIUM_NAME varchar(50) NULL);
CREATE Table PULPIT
(PULPIT char(20) NOT NULL constraint PK_PULPIT primary key(PULPIT),
PULPIT_NAME varchar(100),
FACULTY char(10) NOT NULL constraint FK_PULPIT_FACULTY foreign key(FACULTY) references FACULTY(FACULTY));
CREATE Table PROFESSION
(PROFESSION char(20) NOT NULL constraint PK_PROFESSION primary key(PROFESSION),
FACULTY char(10) NOT NULL constraint FK_PROFESSION_FACULTY foreign key(FACULTY) references FACULTY(FACULTY),
PROFESSION_NAME varchar(100),
QUALIFICATION varchar(50));
CREATE Table [SUBJECT]
([SUBJECT] char(10) NOT NULL constraint PK_SUBJECT primary key([SUBJECT]),
SUBJECT_NAME varchar(100) unique,
PULPIT char(20) NOT NULL constraint FK_SUBJECT_PULPIT foreign key(PULPIT) references PULPIT(PULPIT));
CREATE Table GROUPS
(IDGROUP int NOT NULL constraint PK_GROUPS primary key(IDGROUP),
FACULTY char(10) NOT NULL constraint FK_GROUPS_FACULTY foreign key(FACULTY) references FACULTY(FACULTY),
PROFESSION char(20) NOT NULL constraint FK_GROUPS_PROFESSION foreign key(PROFESSION) references PROFESSION(PROFESSION),
YEAR_FIRST smallint check(YEAR_FIRST<YEAR(GETDATE())+2),
COURSE as YEAR(GETDATE())-YEAR_FIRST);
CREATE Table STUDENT
(IDSTUDENT int identity(1000,1) constraint PK_STUDENT primary key(IDSTUDENT),
IDGROUP int NOT NULL constraint FK_STUDENT_IDGROUP foreign key(IDGROUP) references GROUPS(IDGROUP),
SNAME nvarchar(100),
BDAY date,
STAMP timestamp,
INFO xml default null,
FOTO varbinary(max) default null);
CREATE Table PROGRESS
([SUBJECT] char(10) constraint FK_PROGRESS_SUBJECT foreign key([SUBJECT]) references [SUBJECT]([SUBJECT]),
IDSTUDENT int constraint FK_PROGRESS_IDSTUDENT foreign key(IDSTUDENT) references STUDENT(IDSTUDENT),
PDATE date,
NOTE int check(NOTE between 1 and 10));
CREATE Table TEACHER
(TEACHER char(10) NOT NULL constraint PK_TEACHER primary key(TEACHER),
TEACHER_NAME varchar(100),
GENDER char(1) check(GENDER in ('�','�')),
PULPIT char(20) NOT NULL constraint FK_TEACHER_PULPIT foreign key(PULPIT) references PULPIT(PULPIT));
INSERT into FACULTY(FACULTY,FACULTY_NAME)
values ('����','���������� � ������� ������ ��������������'),
('���','���������� ������������ �������'),
('����','���������� ���������� � �������'),
('���','���������-�������������'),
('���','�����������������'),
('���','��������������� � �����������������'),
('��','�������������� ����������');
INSERT into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
values ('��-�','���������� �����������'),
('��-�','������������ �����'),
('��-��','����. ������������ �����'),
('��','����������'),
('��-�','���������� � ���. ����������');
INSERT into PULPIT(PULPIT,PULPIT_NAME,FACULTY)
values ('���','�����������-������������ ����������','���'),
('������','����������, �������������� �����, ������� � ������','���'),
('���','���������� ������������������� �����������','����'),
('�����','���������� � ������� ������� �� ���������','����'),
('���','������� � ������������������','���'),
('��','���������� ����','����'),
('�������','���������� �������������� ������� � ����� ���������� ����������','����'),
('��������','���������� ���������������� ������� � ����������� ���������� ����������','���'),
('���','���������� ����������� ���������','���'),
('��������','�����, ���������� ����������������� ����������� � ���������� ����������� �������','����'),
('����','������������� ������ � ����������','���'),
('����','�������������� ������ � ����������','��'),
('��','�����������','���'),
('������','���������������� ������������ � ������ ��������� ����������','���'),
('����','���������� � ������� ������ ��������������','����');
INSERT into PROFESSION(PROFESSION,FACULTY,PROFESSION_NAME,QUALIFICATION)
values ('1-25 01 07','���','��������� � ���������� �� �����������','���������-��������'), 
('1-25 01 08','���','������������� ����, ������ � �����','���������'),
('1-36 05 01','����','������ � ������������ ������� ���������','�������-�������'),
('1-36 06 01','���','��������������� ������������ � ������� ��������� ����������','�������-��������������'),
('1-36 07 01','����','������ � �������� ���������� ����������� � ����������� ������������ ����������','�������-�������'),
('1-40 01 02','��','�������������� ������� � ����������','�������-�����������-�������������'),
('1-46 01 01','����','�������������� ����','�������-��������'),
('1-47 01 01','���','������������ ����','��������-��������'),
('1-48 01 02','���','���������� ���������� ������������ �������, ���������� � �������','�������-�����-��������'),
('1-48 01 05','���','���������� ���������� ����������� ���������','�������-�����-��������'),
('1-54 01 03','���','������-���������� ������ � ������� �������� �������� ���������','������� �� ������������'),
('1-75 01 01','���','������ ���������','������� ������� ���������'),
('1-75 02 01','���','������-�������� �������������','������� ������-��������� �������������'),
('1-89 02 02','���','������ � ������������������','���������� � ���� �������');
INSERT into AUDITORIUM(AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
values ('301-1','��-�','15','301-1'),
('304-4','��-�','90','304-4'),
('313-1','��-�','60','313-1'),
('314-4','��','90','314-4'),
('320-4','��','90','320-4'),
('324-1','��-�','50','324-1'),
('413-1','��-�','15','413-1'),
('423-1','��-�','90','423-1');
INSERT into [SUBJECT]([SUBJECT],SUBJECT_NAME,PULPIT)
values ('��','������������� ������ � ������������ ��������','����'),
('���','���������������� �������������� ������','����'),
('���','���������������� �������� ����������','����'),
('���','���������� ������������','��������'),
('����','������� ���������� ������ ������','����'),
('���','���������� ��������� �������','��������'),
('��','������������� ������','����'),
('��','���� ������','����'),
('����','������ �������������� � ����������������','����');
INSERT into GROUPS(IDGROUP,FACULTY,PROFESSION,YEAR_FIRST)
values ('22','���','1-75 02 01','2011'),
('23','���','1-89 02 02','2012'),
('24','���','1-89 02 02','2011'),
('25','����','1-36 05 01','2013'),
('26','����','1-36 05 01','2012'),
('27','����','1-46 01 01','2012'),
('28','���','1-25 01 07','2013'),
('29','���','1-25 01 07','2012'),
('30','���','1-25 01 07','2010'),
('31','���','1-25 01 08','2013'),
('32','���','1-25 01 08','2012');
INSERT into STUDENT(IDGROUP,SNAME,BDAY)
values ('22','����� ������ ����������','12/01/1996'),
('23','������ ������� ��������','19/07/1996'),
('24','������ ����� ����������','22/05/1996'),
('25','������ ������ ��������','08/12/1996'),
('26','������ ������ ����������','11/11/1995'),
('27','������ ������� ����������','24/08/1996'),
('28','����� ���� �������������','15/09/1996'),
('29','������ ���� ��������','16/10/1996');
INSERT into PROGRESS([SUBJECT],IDSTUDENT,PDATE,NOTE)
values ('����','1000','12.01.2014','4'),
('����','1001','19/01/2014','5'),
('����','1003','08/01/2014','9'),
('��','1002','11/01/2014','8'),
('��','1004','15/01/2014','4'),
('����','1006','16/01/2014','7'),
('����','1007','27/01/2014','6');
INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values ('����','������ ������ ����������','�','����'),
('����','���������� ������� ��������','�','��������'),
('����','�������� ����� ����������','�','����'),
('����','������ ������ ����������','�','��'),
('����','������� ������� ����������','�','����'),
('����','������ �������� �������������','�','����'),
('����','������ ����� ��������','�','����'),
('���','������� ���� ����������','�','���'),
('���','����� ������ ���������','�','������');*/

Select AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM Inner Join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE;

Select AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM Inner Join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE And
AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%���������%';

Select AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM, AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE;
Select AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM, AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE And
AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%���������%';

Select FACULTY.FACULTY,PULPIT.PULPIT,PROFESSION.PROFESSION,[SUBJECT].[SUBJECT],STUDENT.SNAME,
Case
when (PROGRESS.NOTE=6) then '�����'
when (PROGRESS.NOTE=7) then '����'
when (PROGRESS.NOTE=8) then '������'
end NOTE
from FACULTY 
inner join PULPIT
	on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION
	on PULPIT.FACULTY = PROFESSION.FACULTY
inner join [SUBJECT]
	on [SUBJECT].PULPIT = PULPIT.PULPIT
inner join PROGRESS
	on PROGRESS.[SUBJECT] = [SUBJECT].[SUBJECT]
inner join STUDENT
	on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT and PROGRESS.NOTE between 6 and 8
ORDER BY FACULTY.FACULTY ASC, PULPIT.PULPIT ASC, PROFESSION.PROFESSION ASC, STUDENT.SNAME ASC, PROGRESS.NOTE DESC;

Select FACULTY.FACULTY,PULPIT.PULPIT,PROFESSION.PROFESSION,[SUBJECT].[SUBJECT],STUDENT.SNAME,
Case
when (PROGRESS.NOTE=6) then '�����'
when (PROGRESS.NOTE=7) then '����'
when (PROGRESS.NOTE=8) then '������'
end NOTE
from FACULTY 
inner join PULPIT
	on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION
	on PULPIT.FACULTY = PROFESSION.FACULTY
inner join [SUBJECT]
	on [SUBJECT].PULPIT = PULPIT.PULPIT
inner join PROGRESS
	on PROGRESS.[SUBJECT] = [SUBJECT].[SUBJECT]
inner join STUDENT
	on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT AND PROGRESS.NOTE BETWEEN 6 and 8
ORDER BY 
(Case
	when PROGRESS.NOTE=6 then 3
	when PROGRESS.NOTE=8 then 2
	else 1
end
);

SELECT isnull(TEACHER.TEACHER_NAME, '***'), PULPIT.PULPIT_NAME
from PULPIT left outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT;

SELECT isnull(TEACHER.TEACHER_NAME, '***'), PULPIT.PULPIT_NAME
from TEACHER left outer join PULPIT
on PULPIT.PULPIT = TEACHER.PULPIT;
SELECT isnull(TEACHER.TEACHER_NAME, '***'), PULPIT.PULPIT_NAME
from PULPIT right outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT;

Select * from AUDITORIUM FULL OUTER JOIN AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
Select * from AUDITORIUM left OUTER JOIN AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
Select * from AUDITORIUM right OUTER JOIN AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
Select * from AUDITORIUM inner JOIN AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

Select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM cross JOIN AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE