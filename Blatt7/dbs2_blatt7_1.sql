--a) Wie viele Personen sind alleine in einer Abteilung?
SELECT COUNT(DISTINCT pnr)      --distinct unnoetig
FROM Pers p
WHERE NOT EXISTS
 (SELECT * FROM pers p2         --unterabfrage vermeiden
 WHERE p.anr = p2.anr AND p.pnr != p2.pnr);
 

--loesung(anzahl abteilingsnummern die nur einmal vorkommen in pers)
select count(anr)
from pers
group by anr
having count(*)=1;



--b) In welchen Abteilungen arbeiten keine Programmierer?
SELECT a.aname
FROM abt a
WHERE NOT EXISTS 
(SELECT * FROM pers p      --unterabfrage durch join vermeiden
 WHERE p.anr = a.anr     
AND beruf = 'Programmierer');

--Loesung 
Select aname
from abt
where anr not in(
select (a.anr)        
from abt a, pers p
where a.anr = p.anr AND  p.beruf = 'Programmierer');



--c) Wie viele Personen verdienen mehr als das Durchschnittsgehalt aller Programmierer?
SELECT COUNT(DISTINCT p.pnr)            --distinct unnoetig
FROM pers p
WHERE p.gehalt > (SELECT AVG(gehalt)        --unkorrelierte unteranfrage,ist also ok
 FROM pers WHERE beruf = 'Programmierer');

--loesung
SELECT COUNT(DISTINCT p.pnr)            --distinct unnoetig
FROM pers p
WHERE p.gehalt > (SELECT AVG(gehalt)        --unkorrelierte unteranfrage,ist also ok
 FROM pers WHERE beruf = 'Programmierer');



--d) Welche Personen haben einen Chef der jünger ist als sie selbst?
SELECT p1.Name
FROM Pers p1
WHERE p1.jahrg < (SELECT p2.jahrg FROM pers p2      --korrelierte unteranfrage durch join vermeiden
 WHERE p2.pnr = p1.vnr);
 
--loesung
select p1.name
from pers p1, pers p2
where p1.vnr = p2.pnr and p2.jahrg > p1.jahrg; --jahrgang von vorgesetzten ist groesser



--e) Ermittle alle Personen,die in der gleichen Abteilung wie Hr. Junghans arbeiten und den gleichen Beruf haben
SELECT DISTINCT name
FROM Pers
WHERE name != 'Junghans'
AND beruf = ANY(SELECT beruf FROM Pers      --unterabfragen vermeiden durch join
 WHERE name = 'Junghans')
AND anr = ANY(SELECT anr FROM Pers
 WHERE name = 'Junghans');

--loesung
 
Select p1.name
from pers p1,pers p2
where p1.anr = p2.anr 
AND p1.pnr!= p2.pnr 
AND p1.beruf = p2.beruf 
AND p1.name!='Junghans';

--f) Suche alle Mitarbeiter, deren Namen in der Firma nur einmal vorkommt
SELECT DISTINCT name                        --distinct vermeiden
FROM Pers p1
WHERE NOT EXISTS (SELECT * FROM Pers p2     --korrelierte unteranfrage vermeiden
 WHERE p1.name = p2.name
 AND p1.pnr != p2.pnr);
 
--loesung (auch mit having count moeglich)
Select name
from pers p3
where name not in(
SELECT p1.name
from pers p1,pers p2
where p1.name = p2.name AND p1.pnr != p2.pnr);

 
--g) Welche Mitarbeiternamen kommen in der Firma auch als Abteilungsname vor?
SELECT DISTINCT p.name
FROM Pers p
WHERE EXISTS (SELECT * FROM Abt a       --korrelierte unteranfrage vermeiden
 WHERE p.name = a.aname);
 
--loesung
Select distinct p.name 
from pers p, abt a
where p.name = a.aname;






