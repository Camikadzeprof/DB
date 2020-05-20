use Лаба3;
Create Table STUDENTS(
	[Номер зачётки] int primary key,
	ФИО nvarchar(50),
	Пол nchar(1) default 'м' check(Пол in ('м','ж')),
	[Дата рождения] date,
	[Дата поступления] date);