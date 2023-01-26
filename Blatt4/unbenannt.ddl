CREATE TABLE Studiengang (Kuerzel varchar2(255) NOT NULL, Name varchar2(255), Abschluss varchar2(255), PRIMARY KEY (Kuerzel));
CREATE TABLE Vorlesung (ID number(10) GENERATED AS IDENTITY, StudiengangKuerzel varchar2(255) NOT NULL, Name varchar2(255), Ects number(10) NOT NULL, Sws number(10) NOT NULL, PRIMARY KEY (ID));
ALTER TABLE Vorlesung ADD CONSTRAINT enthalten FOREIGN KEY (StudiengangKuerzel) REFERENCES Studiengang (Kuerzel);
