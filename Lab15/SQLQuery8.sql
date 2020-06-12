use Lab5;
--1
--Разработать AFTER-триггер для таблицы TEACHER, реагир на событие INSERT
--запис. строки вводимых данных в таблицу TR_AUDIT
--В столбец СС помещаются значения столбцов вводимой строки. 

/*go 
create table TR_AUDIT
(
ID int identity,
STMT varchar(20)
check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50),
CC varchar(300)
)



	go
    create  trigger TR_TEACHER_INS 
      on TEACHER after INSERT  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Вставка';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	         
      return;  
      go

	  insert into  TEACHER values('ИВНВ', 'Иванов', 'м', 'ИСиТ');
	  select * from TR_AUDIT
	  delete from TEACHER where TEACHER='ИВНВ';*/



--2
--Создать AFTER-триггер с именем TR_TEACHER_DEL для таблицы TEACHER, реагирующий 
--на событие DELETE. Триггер TR_TEACHER_DEL должен записывать стро-ку данных в таблицу TR_AUDIT 
--для каждой удаляемой строки. В столбец СС помещаются значения столбца TEACHER удаляемой стро-ки. 

/*go
    create  trigger TR_TEACHER_DEL 
      on TEACHER after DELETE  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Удаление';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);	         
      return;  
      go 
	   delete TEACHER where TEACHER='ИВНВ'
	  select * from TR_AUDIT*/

	

--3
--Создать AFTER-триггер с именем TR_TEACHER_UPD для таблицы TEACHER, реагирующий на событие UPDATE. 
--Триггер TR_TEACHER_UPD должен записывать стро-ку данных в таблицу TR_AUDIT для каждой изменяемой строки. 
--В столбец СС помещаются значения всех столбцов изменяемой строки до и после изменения.

/*go
    alter  trigger TR_TEACHER_DEL 
      on TEACHER after UPDATE  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 

      print 'Обновление';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      set @a1 = (select TEACHER from deleted);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in =@in + '' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in);	         
      return;  
      go

	  update TEACHER set GENDER = 'ж' where TEACHER='КРЛВ'
	  select * from TR_AUDIT

	  delete from TR_AUDIT where STMT = 'UPD'*/

--4 
--Создать AFTER-триггер с именем TR_TEACHER для таблицы TEACHER, реа-гирующий на события 
--INSERT, DELETE, UPDATE. Триггер TR_TEACHER должен за-писывать строку данных в таблицу TR_AUDIT 
--для каждой изменяемой строки. В коде тригге-ра определить событие, активизировавшее триггер и 
--поместить в столбец СС соответству-ющую событию информацию. Разработать сце-нарий, демонстрирующий 
--работоспособность триггера. 

/*go
create trigger TR_TEACHER   on TEACHER after INSERT, DELETE, UPDATE  
 as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
   if  @ins > 0 and  @del = 0
   begin
   print 'Событие: INSERT';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	
	 end;
	else		  	 
    if @ins = 0 and  @del > 0
	begin
	print 'Событие: DELETE';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);
	  end;
	else	  
    if @ins > 0 and  @del > 0
	begin
	print 'Событие: UPDATE'; 
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      set @a1 = (select TEACHER from deleted);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in =@in + '' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in); 
	  end;
	  return;  

	  delete TEACHER where TEACHER='ИВНВ'
	  insert into  TEACHER values('ИВНВ', 'Иванов', 'м', 'ИСиТ');
	  	  update TEACHER set GENDER = 'ж' where TEACHER='КРЛВ'
	  select * from TR_AUDIT;*/

--5
--Разработать сценарий, который демонстрирует на примере базы данных X_BSTU, что провер-ка
-- ограничения целостности выполняется до срабатывания AFTER-триггера.


/*update TEACHER set GENDER = 'м' where TEACHER='КРЛВ'
 select * from TR_AUDIT;*/

--6
--Создать для таблицы TEACHER три AFTER-триггера с именами: TR_TEACHER_ DEL1, TR_TEACHER_DEL2 и TR_TEACHER_ DEL3. 
--Триггеры должны реагировать на собы-тие DELETE и формировать соответствующие строки в таблицу TR_AUDIT.

/*go   
create trigger TR_TEACHER_DEL1 on FACULTY after DELETE  
as print 'TR_TEACHER_DEL1';
 return;  
go 
create trigger TR_TEACHER_DEL2 on FACULTY after DELETE  
as print 'TR_TEACHER_DEL2';
 return;  
go  
create trigger TR_TEACHER_DEL3 on FACULTY after DELETE  
as print 'TR_TEACHER_DEL3';
 return;  
go    


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order='First', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order='Last', @stmttype = 'DELETE';


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE';*/
 
--7

--Разработать сценарий, демонстрирующий на примере базы данных X_BSTU утверждение: 
--AFTER-триггер является частью транзакции, в рамках которого выполняется оператор, акти-визировавший триггер.

/*
go 
	create trigger PTran 
	on PULPIT after INSERT, DELETE, UPDATE  
	as declare @c int = (select count (*) from PULPIT); 	 
	 if (@c >26) 
	 begin
       raiserror('Общее количество кафедр не может быть >26', 10, 1);
	 rollback; 
	 end; 
	 return;          

	insert into PULPIT(PULPIT) values ('ТТПЛ')*/

--8

--Создать для таблицы FACULTY INSTEAD OF-триггер, запрещающий удаление строк в таблице. 
--Разработать сценарий, который демонстри-рует на примере базы данных X_BSTU, 
--что проверка ограничения целостности выполнена, если есть INSTEADOF-триггер.

--С помощью оператора DROP удалить все DML-триггеры, созданные в этой лабораторной работе.


	/*go 
	create trigger F_INSTEAD_OF 
	on FACULTY instead of DELETE 
	as 
raiserror(N'Удаление запрещено', 10, 1);
	return;

	 delete FACULTY where FACULTY = 'ПиМ'

	 drop trigger F_INSTEAD_OF
	 drop trigger PTran
	 drop trigger TR_TEACHER
	 drop trigger TR_TEACHER_DEL

go
select * from FACULTY;
*/
--9
--Создать DDL-триггер, реагирующий на все DDL-события в БД UNIVER.
--Триггер должен запрещать создавать новые таблицы и удалять существующие.
--Свое выполнение триггер должен сопровождать сообщением, которое содержит:
--тип события, имя и тип объекта, а также пояснительный текст, в случае запрещения выполнения оператора. 
--Разработать сценарий, демонстрирующий работу триггера. 

/*go

create  trigger DDL_Lab5 on database 
                          for DDL_DATABASE_LEVEL_EVENTS  as   
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INS- TANCE/EventType)[1]', 'varchar(50)');
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectType)[1]', 'varchar(50)'); 
  if @t2 = 'Table' and (@t = 'CREATE' or @t = 'DROP')
  begin
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'операции добавления/удаления таблиц запрещены', 16, 1);  
       rollback;    
end;
go
Create Table h(ht int);
drop trigger DDL_Lab5;*/