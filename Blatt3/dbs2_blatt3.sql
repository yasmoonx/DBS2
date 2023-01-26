drop table ProfessorTab;
drop table FakultaetTab;
drop table StudiengangTab;
drop table StudierenderTab;
drop table PruefungsergebnisTab;
drop table VorlesungTab;

drop type PersonT force;
drop type ProfessorT force;
drop type ProfessorenVA force;
drop type FakultaetT force ;
drop type StudiengangT force;
drop type StudierenderT force;
drop type VorlesungT force;

CREATE OR REPLACE TYPE PersonT AS OBJECT
(name VARCHAR2(40)) NOT FINAL;
/
CREATE OR REPLACE TYPE ProfessorT UNDER PersonT
(fachgebiet VARCHAR2(40),
buero CHAR(4)) FINAL;
/
CREATE OR REPLACE TYPE ProfessorenVA AS VARRAY(50) OF REF ProfessorT;
/
CREATE OR REPLACE TYPE FakultaetT AS OBJECT
(name VARCHAR2(20),
 dekan REF ProfessorT,
 professoren ProfessorenVA) FINAL;
/
CREATE OR REPLACE TYPE StudiengangT AS OBJECT
(name VARCHAR2(40),
fakultaet REF FakultaetT) FINAL;
/
CREATE OR REPLACE TYPE StudierenderT UNDER PersonT
(matrikelnummer VARCHAR(6),
 studiengang REF StudiengangT,
 MEMBER FUNCTION getNotenschnitt RETURN FLOAT
 ) FINAL;
/



CREATE OR REPLACE TYPE VorlesungT AS OBJECT
(name VARCHAR2(40),
professor REF ProfessorT) FINAL;
/
CREATE TABLE ProfessorTab OF ProfessorT;
CREATE TABLE FakultaetTab OF FakultaetT
(dekan SCOPE IS ProfessorTab);
CREATE TABLE StudiengangTab OF StudiengangT
(fakultaet SCOPE IS FakultaetTab);
CREATE TABLE StudierenderTab OF StudierenderT
(studiengang SCOPE IS StudiengangTab);
CREATE TABLE VorlesungTab OF VorlesungT
(professor SCOPE IS ProfessorTab);

-- Erweiterung

CREATE OR REPLACE TYPE PruefungsergebnisT AS OBJECT
(pruefungsdatum DATE,
note NUMBER(2,1),
vorlesung REF VorlesungT,
student REF StudierenderT
) FINAL;
/

CREATE TABLE PruefungsergebnisTab OF PruefungsergebnisT(
CONSTRAINT Notenwerte CHECK(note IN
(1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0)));

-- Inserts

Insert into ProfessorTab Values (ProfessorT('Hanno Langweg','Security','O101'));
Insert into ProfessorTab Values (ProfessorT('Oliver Eck','DBS','O102'));
Insert into ProfessorTab Values (ProfessorT('Michael Blaich','Robotik','O103'));
Insert into ProfessorTab Values (ProfessorT('Rebekka Axthelm','Mathematik','O104'));

Insert into FakultaetTab Values (FakultaetT('Informatik',
(Select REF(a) From ProfessorTab a where a.name='Hanno Langweg'),
ProfessorenVA((Select REF(a) From ProfessorTab a where a.name='Hanno Langweg'),
(Select REF(a) From ProfessorTab a where a.name='Oliver Eck'),
(Select REF(a) From ProfessorTab a where a.name='Michael Blaich'))));

Insert into FakultaetTab Values (FakultaetT('Mathematik',
(Select REF(a) From ProfessorTab a where a.name='Rebekka Axthelm'),
ProfessorenVA((Select REF(a) From ProfessorTab a where a.name='Rebekka Axthelm'))));

Insert into VorlesungTab Values (VorlesungT('DBS2',(Select REF(a) From ProfessorTab a where a.name='Oliver Eck')));
Insert into VorlesungTab Values (VorlesungT('DBS1',(Select REF(a) From ProfessorTab a where a.name='Oliver Eck')));
Insert into VorlesungTab Values (VorlesungT('Mathematik1',(Select REF(a) From ProfessorTab a where a.name='Rebekka Axthelm')));

Insert into StudiengangTab Values (StudiengangT('AIN',(Select REF(a) From FakultaetTab a where a.name='Informatik')));
Insert into StudiengangTab Values (StudiengangT('WIN',(Select REF(a) From FakultaetTab a where a.name='Informatik')));
Insert into StudiengangTab Values (StudiengangT('MAT',(Select REF(a) From FakultaetTab a where a.name='Mathematik')));

Insert into StudierenderTab Values (StudierenderT('Chris','123456',(Select REF(a) From StudiengangTab a where a.name='AIN')));
Insert into StudierenderTab Values (StudierenderT('Yasmin','123457',(Select REF(a) From StudiengangTab a where a.name='AIN')));
Insert into StudierenderTab Values (StudierenderT('Adrian','123458',(Select REF(a) From StudiengangTab a where a.name='WIN')));
Insert into StudierenderTab Values (StudierenderT('Leonie','123459',(Select REF(a) From StudiengangTab a where a.name='MAT')));

INSERT INTO PRUEFUNGSERGEBNISTAB VALUES (
    TO_DATE('01.01.2022', 'DD.MM.YYYY'),
    1.0,
    (SELECT REF(A) FROM VORLESUNGTAB A WHERE A.NAME = 'DBS2'),
    (SELECT REF(A) FROM STUDIERENDERTAB A WHERE A.MATRIKELNUMMER = '123456' )
);
INSERT INTO PRUEFUNGSERGEBNISTAB VALUES (
    TO_DATE('01.01.2022', 'DD.MM.YYYY'),
    1.0,
    (SELECT REF(A) FROM VORLESUNGTAB A WHERE A.NAME = 'DBS2'),
    (SELECT REF(A) FROM STUDIERENDERTAB A WHERE A.MATRIKELNUMMER = '123457' )
);
INSERT INTO PRUEFUNGSERGEBNISTAB VALUES (
    TO_DATE('01.01.2022', 'DD.MM.YYYY'),
    3.0,
    (SELECT REF(A) FROM VORLESUNGTAB A WHERE A.NAME = 'DBS2'),
    (SELECT REF(A) FROM STUDIERENDERTAB A WHERE A.MATRIKELNUMMER = '123458' )
);
INSERT INTO PRUEFUNGSERGEBNISTAB VALUES (
    TO_DATE('01.01.2022', 'DD.MM.YYYY'),
    1.0,
    (SELECT REF(A) FROM VORLESUNGTAB A WHERE A.NAME = 'DBS2'),
    (SELECT REF(A) FROM STUDIERENDERTAB A WHERE A.MATRIKELNUMMER = '123459' )
);
INSERT INTO PRUEFUNGSERGEBNISTAB VALUES (
    TO_DATE('01.01.2022', 'DD.MM.YYYY'),
    1.0,
    (SELECT REF(A) FROM VORLESUNGTAB A WHERE A.NAME = 'DBS1'),
    (SELECT REF(A) FROM STUDIERENDERTAB A WHERE A.MATRIKELNUMMER = '123459' )
);
INSERT INTO PRUEFUNGSERGEBNISTAB VALUES (
    TO_DATE('01.01.2022', 'DD.MM.YYYY'),
    2.0,
    (SELECT REF(A) FROM VORLESUNGTAB A WHERE A.NAME = 'Mathematik1'),
    (SELECT REF(A) FROM STUDIERENDERTAB A WHERE A.MATRIKELNUMMER = '123459' )
);

-- Aufgabe 2 Selects 

Select P.student.name, P.note
from PruefungsergebnisTab P
where P.vorlesung.name = 'DBS2'
AND P.note < 2
;

Select S.name
from StudierenderTab S
where S.studiengang.fakultaet.dekan.name ='Hanno Langweg';

Select P.Column_Value.name
from FakultaetTab F, Table(F.professoren) P
where F.name = 'Informatik';

--Aufgabe 3 Funktion

Create or replace Type Body StudierenderT AS
Member function getNotenschnitt RETURN FLOAT IS schnitt float;
BEGIN
SELECT avg(p.note) INTO schnitt FROM PruefungsergebnisTab p where p.student.matrikelnummer = self.matrikelnummer;
return schnitt ;
END getNotenschnitt;
END;
/

Select s.matrikelnummer AS matrikelnummer, s.name AS name,s.getNotenschnitt() as Notenschnitt
from studierenderTab s;

commit;