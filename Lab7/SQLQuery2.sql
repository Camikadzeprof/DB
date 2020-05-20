use Lab5;

--1. ����� ����., ���., �����. �������-��� ��������� + ��������� � ���.���-��
Select 
	min(AUDITORIUM_CAPACITY) as 'min',
	max(AUDITORIUM_CAPACITY) as 'max',
	avg(AUDITORIUM_CAPACITY) as 'avg',
	sum(AUDITORIUM_CAPACITY) as 'sum_capacity',
	count(*) as 'count_of_auditoriums'
		from AUDITORIUM

--2. ����.,���.,�����.,����. � ���.���-�� ��������� �����.����
Select
	AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,
	min(AUDITORIUM_CAPACITY) as 'min',
	max(AUDITORIUM_CAPACITY) as 'max',
	avg(AUDITORIUM_CAPACITY) as 'avg',
	sum(AUDITORIUM_CAPACITY) as 'sum_capacity',
	count(*) as 'count_of_auditoriums'
		from AUDITORIUM inner join AUDITORIUM_TYPE
		on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
		group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME

--3. ���-� �� ���.����.�������� - ���-�� ���.������� � �����.���-��; ������.�� ����.
Select * From (
	select Case 
				when PROGRESS.NOTE = 10 then '10'
				when PROGRESS.NOTE = 8 or PROGRESS.NOTE = 9 then '8-9'
				when PROGRESS.NOTE = 6 or PROGRESS.NOTE = 7 then '6-7'
				else '4-5' 
				end [������], COUNT(*)[����������]
	from PROGRESS group by Case 
								when PROGRESS.NOTE = 10 then '10'
								when PROGRESS.NOTE = 8 or PROGRESS.NOTE = 9 then '8-9'
								when PROGRESS.NOTE = 6 or PROGRESS.NOTE = 7 then '6-7'
								else '4-5' 
								end
				) as T
Order by Case[������]
			when '10' then 1
			when '8-9' then 2
			when '6-7' then 3
			when '4-5' then 4
			else 0
			end

--4 ������, ���.������.������ ��� ������ ����� ����� �������; ����.��.��.(� ����.�� 2 ������ ����� ,)
select FACULTY.FACULTY, GROUPS.PROFESSION,-- GROUPS.COURSE,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by FACULTY.FACULTY, GROUPS.PROFESSION--, GROUPS.COURSE;

--5 �������.������, � 4 ������� ���, ����� ��� ������ �� �� � ����
select FACULTY.FACULTY, GROUPS.PROFESSION,-- GROUPS.COURSE,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.[SUBJECT]='����' or PROGRESS.[SUBJECT] = '����'
group by FACULTY.FACULTY, GROUPS.PROFESSION--, GROUPS.COURSE;

--6 ������, ���.������� �������, ���������� � ������ �� ��� � ���-���� ROLLUP
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY='���'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY

--7 ������ � ���-��� ����� ���-��
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY like '����'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY
union all
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY like '��'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY

--8
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY like '����'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY
intersect
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY like '��'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY;

--9
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY like '����'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY
except
Select GROUPS.PROFESSION, PROGRESS.[SUBJECT],GROUPS.FACULTY,
round (avg (cast (PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join FACULTY
on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY like '��'
group by GROUPS.PROFESSION, PROGRESS.[SUBJECT], GROUPS.FACULTY;

--10
select p1.SUBJECT, p1.NOTE,
(
	select COUNT(*) from PROGRESS p2
	where p2.SUBJECT = p1.SUBJECT and p2.NOTE = p1.NOTE
)[����������]
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE = 8 or NOTE = 9
order by NOTE;