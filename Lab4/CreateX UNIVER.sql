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
GENDER char(1) check(GENDER in ('м','ж')),
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
values ('ТТЛП','Технологии и техники лесной промышленности'),
('ТОВ','Технологии органических веществ'),
('ХТиТ','Химические технологии и техника'),
('ИЭФ','Инженерно-экономический'),
('ЛХФ','Лесохозяйственный'),
('ПиМ','Принттехнологий и медиакоммуникаций'),
('ИТ','Информационных технологий');
INSERT into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
values ('ЛБ-Х','Химическая лаборатория'),
('ЛБ-К','Компьютерный класс'),
('ЛБ-СК','Спец. компьютерный класс'),
('ЛК','Лекционная'),
('ЛК-К','Лекционная с уст. проектором');
INSERT into PULPIT(PULPIT,PULPIT_NAME,FACULTY)
values ('РИТ','Редакционно-издательских технологий','ПиМ'),
('СБУАиА','Статистики, бухгалтерского учёта, анализа и аудита','ИЭФ'),
('ТДП','Технологий древообрабатывающих производств','ТТЛП'),
('ТиДИД','Технологии и дизайна изделий из древесины','ТТЛП'),
('ТиП','Туризма и природопользования','ЛХФ'),
('ТЛ','Транспорта леса','ТТЛП'),
('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии','ХТиТ'),
('ТНХСиППМ','Технологии нефтехимического синтеза и переработки полимерных материалов','ТОВ'),
('ХПД','Химической переработки древесины','ТОВ'),
('ХТЭПиМЭЕ','Химии, технологии электрохимических производств и материалов электронной техники','ХТиТ'),
('ЭТиМ','Экономической теории и маркетинга','ИЭФ'),
('ИСиТ','Информационных систем и технологий','ИТ'),
('ЛВ','Лесоводства','ЛХФ'),
('ПОиСОИ','Полиграфического оборудования и систем обработки информации','ПиМ'),
('ТТЛП','Технологий и техники лесной промышленности','ТТЛП');
INSERT into PROFESSION(PROFESSION,FACULTY,PROFESSION_NAME,QUALIFICATION)
values ('1-36 06 01','ПиМ','Полиграфическое оборудование и системы обработки информации','инженер-электромеханик'),
('1-36 07 01','ХТиТ','Машины и аппараты химических производств и предприятий строительных материалов','инженер-механик'),
('1-40 01 02','ИТ','Информационные системы и технологии','инженер-программист-системотехник'),
('1-46 01 01','ТТЛП','Лесоинженерное дело','инженер-технолог'),
('1-47 01 01','ПиМ','Издательское дело','редактор-технолог'),
('1-48 01 02','ТОВ','Химическая технология органическиз веществ, материалов и изделий','инженер-химик-технолог'),
('1-48 01 05','ТОВ','Химическая технология переработки древесины','инженер-химик-технолог'),
('1-54 01 03','ТОВ','Физико-химические методы и приборы контроля качества продукции','инженер по сертификации'),
('1-75 01 01','ЛХФ','Лесное хозяйство','инженер лесного хозяйства'),
('1-75 02 01','ЛХФ','Садово-парковое строительство','инженер садово-паркового строительства'),
('1-89 02 02','ЛХФ','Туризм и природопользование','специалист в сфре туризма');
INSERT into GROUPS(IDGROUP,FACULTY,PROFESSION,YEAR_FIRST)
values ('22','ЛХФ','1-75 02 01','2011'),
('23','ЛХФ','1-89 02 02','2012'),
('24','ЛХФ','1-89 02 02','2011'),
('25','ТТЛП','1-36 05 01','2013'),
('26','ТТЛП','1-36 05 01','2012'),
('27','ТТЛП','1-46 01 01','2012'),
('28','ИЭФ','1-25 01 07','2013'),
('29','ИЭФ','1-25 01 07','2012'),
('30','ИЭФ','1-25 01 07','2010'),
('31','ИЭФ','1-25 01 08','2013'),
('32','ИЭФ','1-25 01 08','2012');
INSERT into [SUBJECT]([SUBJECT],SUBJECT_NAME,PULPIT)
values ('ПЗ','Представление знаний в компьютерных системах','ИСиТ'),
('ПИС','Программирование информационных систем','ИСиТ'),
('ПСП','Программирование интернет приложений','ИСиТ'),
('ПЭХ','Прикладная электрохимия','ХТЭПиМЭЕ'),
('СУБД','Системы управления базами данных','ИСиТ'),
('ТРИ','Технология резиновых изделий','ТНХСиППМ'),
('ЭТ','Экономическая теория','ЭТиМ'),
('БД','Базы данных','ИСиТ'),
('ОАиП','Основы алгоритмизации и программирования','ИСиТ');
INSERT into STUDENT(IDGROUP,SNAME,BDAY)
values ('22','Пугач Михаил Трофимович','12/01/1996'),
('23','Авдеев Николай Иванович','19/07/1996'),
('24','Белова Елена Степановна','22/05/1996'),
('25','Вилков Андрей Петрович','08/12/1996'),
('26','Грушин Леонид Николаевич','11/11/1995'),
('27','Дунаев Дмитрий Михайлович','24/08/1996'),
('28','Клуни Иван Владиславович','15/09/1996'),
('29','Крылов Олег Павлович','16/10/1996');
INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values ('НСКВ','Носков Михаил Трофимович','м','ТТЛП'),
('ПРКП','Прокопенко Николай Иванович','м','ТНХСиППМ'),
('МРЗВ','Морозова Елена Степановна','ж','ИСиТ'),
('РЖКВ','Рожков Леонид Николаевич','м','ЛВ'),
('РМНВ','Романов Дмитрий Михайлович','м','ИСиТ'),
('СМЛВ','Смелов Владимир Владиславович','м','ИСиТ'),
('КРЛВ','Крылов Павел Вавлович','м','ИСиТ'),
('ЧРН','Чернова Анна Викторовна','ж','ХПД'),
('МХВ','Мохов Михаил Сергеевич','м','ПОиСОИ');