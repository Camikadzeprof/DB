use GurskyUNIVER;
Create Table RESULTS(
	ID int primary key identity(1,1),
	NAME_STUDENT nvarchar(20),
	MARK_OOP int,
	MARK_JAVA int,
	MARK_BD int,
	AVER_VALUE as (MARK_OOP+MARK_JAVA+MARK_BD)/3);