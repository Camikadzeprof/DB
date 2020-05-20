use GurskyUNIVER;
SELECT Distinct [Фамилия студента], [Номер группы] From STUDENT Where [Фамилия студента] Like 'Г%';
SELECT Distinct [Фамилия студента], [Номер группы] From STUDENT Where [Номер группы] In (4,6);
SELECT Distinct [Фамилия студента], [Номер группы] From STUDENT Where [Номер зачётки] Between 3568474 And 7896542;