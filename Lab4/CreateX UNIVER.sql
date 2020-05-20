use TMPG_UNIVER;
CREATE Table FACULTY
(FACULTY char(10) NOT NULL primary key(FACULTY),
FACULTY_NAME varchar(50) default '???');
CREATE Table AUDITORIUM_TYPE
(AUDITORIUM_TYPE char(10) NOT NULL constraint PK_AUDITORIUM_TYPE primary key(AUDITORIUM_TYPE),
AUDITORIUM_TYPENAME varchar(30));
CREATE Table PULPIT
(PULPIT char(20) NOT NULL constraint PK_PULPIT primary key(PULPIT),
PULPIT_NAME varchar(100),
FACULTY char(10) NOT NULL constraint FK_PULPIT_FACULTY foreign key(FACULTY) references FACULTY(FACULTY));
CREATE Table PROFESSION
(PROFESSION char(20) NOT NULL constraint PK_PROFESSION primary key(PROFESSION),
FACULTY char(10) NOT NULL constraint FK_PROFESSION_FACULTY foreign key(FACULTY) references FACULTY(FACULTY),
PROFESSION_NAME varchar(100),
QUALIFICATION varchar(50));
CREATE Table TEACHER
(TEACHER char(10) NOT NULL constraint PK_TEACHER primary key(TEACHER),
TEACHER_NAME varchar(100),
GENDER char(1) check(GENDER in ('�','�')),
PULPIT char(20) NOT NULL constraint FK_TEACHER_PULPIT foreign key(PULPIT) references PULPIT(PULPIT));
CREATE Table [SUBJECT]
([SUBJECT] char(10) NOT NULL constraint PK_SUBJECT primary key([SUBJECT]),
SUBJECT_NAME varchar(100) unique,
PULPIT char(20) NOT NULL constraint FK_SUBJECT_PULPIT foreign key(PULPIT) references PULPIT(PULPIT));
CREATE Table AUDITORIUM
(AUDITORIUM char(20) NOT NULL constraint PK_AUDITORIUM primary key(AUDITORIUM),
AUDITORIUM_TYPE char(10) NOT NULL constraint FK_AUDITORIUM_AUDITORIUM_TYPE foreign key(AUDITORIUM_TYPE) references AUDITORIUM_TYPE(AUDITORIUM_TYPE),
AUDITORIUM_CAPACITY int default 1 check (AUDITORIUM_CAPACITY between 1 and 300),
AUDITORIUM_NAME varchar(50));
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
values ('1-36 06 01','���','��������������� ������������ � ������� ��������� ����������','�������-��������������'),
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
INSERT into STUDENT(IDGROUP,SNAME,BDAY)
values ('22','����� ������ ����������','12/01/1996'),
('23','������ ������� ��������','19/07/1996'),
('24','������ ����� ����������','22/05/1996'),
('25','������ ������ ��������','08/12/1996'),
('26','������ ������ ����������','11/11/1995'),
('27','������ ������� ����������','24/08/1996'),
('28','����� ���� �������������','15/09/1996'),
('29','������ ���� ��������','16/10/1996');
INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values ('����','������ ������ ����������','�','����'),
('����','���������� ������� ��������','�','��������'),
('����','�������� ����� ����������','�','����'),
('����','������ ������ ����������','�','��'),
('����','������� ������� ����������','�','����'),
('����','������ �������� �������������','�','����'),
('����','������ ����� ��������','�','����'),
('���','������� ���� ����������','�','���'),
('���','����� ������ ���������','�','������');