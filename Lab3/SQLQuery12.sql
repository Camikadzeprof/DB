use ����3;
Create Table STUDENTS(
	[����� �������] int primary key,
	��� nvarchar(50),
	��� nchar(1) default '�' check(��� in ('�','�')),
	[���� ��������] date,
	[���� �����������] date);