select * from eck.dbestellung;

--Ermittlen sie wem die Tabelle DBestellung gehoert
select owner 
from all_tables 
where table_name= 'DBESTELLUNG';


--Welche attribute sind definiert. Gib attributname und datentyp aus
select column_name, data_type
from all_tab_columns
where table_name='DBESTELLUNG';

--Auf welche Tabellen von Owner=owner(bestellung) haben sie noch Zugriff? Gib die namen aus
select table_name
from all_tables
where owner= (select owner 
from all_tables 
where table_name= 'DBESTELLUNG');

--Addieren sie die Anzahl aller Tupel der Tabellen wo owner=eck
select sum(num_rows) as Anzahl_Tupel
from all_tables
where owner= (select owner 
from all_tables 
where table_name= 'DBESTELLUNG');

--Suchen sie alle foreign keys in DBestellung und geben sie Referenz Tabelle&Attribut an
--foreign keys
select *
from all_constraints
where table_name='DBESTELLUNG' 
AND constraint_type='R';

--referenzierte tabelle 
select table_name from all_constraints where constraint_name=
(select r_constraint_name
from all_constraints
where table_name='DBESTELLUNG' 
AND constraint_type='R');

--referenziertes attribut
--noch nicht fertig all_cons_columns
