DROP TABLE Verkauf_2DC;

DROP TABLE verkaeufe;

DROP TABLE geografie;

DROP TABLE verkaeufer;

DROP TABLE kunden;

DROP TABLE produkte;

CREATE TABLE geografie (
    geo_id       NUMBER PRIMARY KEY,
    filiale      VARCHAR2(30 CHAR) NOT NULL,
    filialleiter VARCHAR2(30 CHAR) NOT NULL,
    stadt        VARCHAR2(30 CHAR) NOT NULL,
    bezirk       VARCHAR2(30 CHAR) NOT NULL,
    land         VARCHAR2(30 CHAR) NOT NULL
);

CREATE TABLE verkaeufer (
    vk_id        NUMBER PRIMARY KEY,
    vk_name      VARCHAR2(20) NOT NULL,
    geburtsdatum DATE NOT NULL,
    fachgebiet   VARCHAR2(40) NOT NULL
);

CREATE TABLE kunden (
    kd_id    NUMBER PRIMARY KEY,
    kd_alter NUMBER NOT NULL,
    wohnland VARCHAR2(20 CHAR) NOT NULL
);

CREATE TABLE produkte (
    produkt_id     NUMBER PRIMARY KEY,
    bezeichnung    VARCHAR2(30 CHAR) NOT NULL,
    preis          NUMBER NOT NULL,
    produktgruppe  VARCHAR2(30 CHAR) NOT NULL,
    hersteller     VARCHAR2(30char) NOT NULL,
    herstellerland VARCHAR2(30char) NOT NULL
);

CREATE TABLE verkaeufe (
    geo_id     NUMBER NOT NULL
        REFERENCES geografie,
    vk_id      NUMBER NOT NULL
        REFERENCES verkaeufer,
    kd_id      NUMBER NOT NULL
        REFERENCES kunden,
    produkt_id NUMBER NOT NULL
        REFERENCES produkte,
    datum DATE  NOT NULL,
    anzahl NUMBER NOT NULL
);
/*Beispielprodukte*/
INSERT INTO produkte VALUES (1,'Zauberwuerfel',4.99,'Spielwaren','Hersteller1','Deutschland');
INSERT INTO produkte VALUES(2,'Trompete',9.99,'Musik','Hersteller2','Kanada');
INSERT INTO produkte VALUES(3,'Mario Kart',199.99,'Spielwaren','Hersteller3','China');
INSERT INTO produkte Values(4,'Seife',1.99,'Drogerie','Hersteller4','Frankreich');
INSERT INTO produkte VALUES(5,'Gitarre',44.99,'Musik','Hersteller2','Kanada');
INSERT INTO produkte VALUES(6,'FFP2-Maske',0.99,'Drogerie','Hersteller5','China');

/*Beispielkunden*/
INSERT INTO kunden VALUES (1, 19, 'Deutschland');
INSERT INTO kunden VALUES (2, 45, 'Schweden');
INSERT INTO kunden VALUES (3, 24, 'Spanien');
INSERT INTO kunden VALUES (4, 45, 'Schweiz');
INSERT INTO kunden VALUES (5, 19, 'Niederlande');
INSERT INTO kunden VALUES (6, 45, 'Deutschland');

/*Beispielverkaeufer*/
INSERT INTO verkaeufer VALUES (1, 'Peter', '13-07-1999', 'Drogerie');
INSERT INTO verkaeufer VALUES (2, 'Susanne', '24-04-1986', 'Spielwaren');
INSERT INTO verkaeufer VALUES (3, 'Luise', '24-12-1970', 'Drogerie');

/*Beispielfiliale*/
INSERT INTO geografie VALUES (1, 'Filialname1', 'Brigitte', 'Konstanz', 'Baden-Wuerttemberg', 'Deutschland'); 

/*Beispielverkaeufe*/
INSERT INTO verkaeufe VALUES (1,1,1,3,'1-1-2020',3);
INSERT INTO verkaeufe VALUES (1,1,1,1,'1-1-2020',2);
INSERT INTO verkaeufe VALUES (1,1,1,4,'1-1-2020',3);
INSERT INTO verkaeufe VALUES (1,1,2,3,'1-1-2020',4);
INSERT INTO verkaeufe VALUES (1,1,2,1,'1-1-2020',1);
INSERT INTO verkaeufe VALUES (1,2,2,4,'1-1-2020',3);
INSERT INTO verkaeufe VALUES (1,3,3,2,'1-1-2020',2);
--INSERT INTO verkaeufe VALUES (1,3,3,1,'1-1-2020',1);
--INSERT INTO verkaeufe VALUES (1,3,3,4,'1-1-2020',1);
INSERT INTO verkaeufe VALUES (1,1,4,6,'1-1-2020',2);
INSERT INTO verkaeufe VALUES (1,2,4,5,'1-1-2020',5);
INSERT INTO verkaeufe VALUES (1,3,5,3,'1-1-2020',1);
INSERT INTO verkaeufe VALUES (1,2,5,1,'1-1-2020',1);
INSERT INTO verkaeufe VALUES (1,3,5,5,'1-1-2020',6);
INSERT INTO verkaeufe VALUES (1,1,6,4,'1-1-2020',1);
INSERT INTO verkaeufe VALUES (1,2,6,6,'1-1-2020',2);
INSERT INTO verkaeufe VALUES (1,3,6,5,'1-1-2021',1); 

/*Aufgabe2: Kunden welchen Alters haben welche Produktgruppe im Jahre 2020 wie h�ufig gekauft*/

CREATE TABLE Verkauf_2DC as
SELECT 
    DECODE(Grouping(k.kd_alter),1,'Alle', k.kd_alter) AS Kundenalter,
    DECODE(Grouping(p.produktgruppe),1,'Alle',p.produktgruppe) AS Produktgruppe,
    SUM(v.Anzahl) AS Anzahl
FROM kunden k,produkte  p,verkaeufe v
WHERE v.kd_id = k.kd_id
AND v.produkt_id = p.produkt_id
AND EXTRACT (YEAR FROM v.datum)= '2020'
GROUP BY CUBE(k.kd_alter, p.produktgruppe);

/*Aufgabe3: Ergebnis in einer Tabellenform mit Spaltenbezeichnungen*/

Select kundenalter, NVL(Drogerie_Anzahl,0) AS Drogerie_anzahl, 
NVL(Musik_anzahl,0) AS Musik_Anzahl, NVL(Spielwaren_anzahl,0) AS Spielwaren_anzahl
FROM  Verkauf_2DC
PIVOT(sum(anzahl) AS Anzahl
    FOR produktgruppe
    IN( 'Musik' AS Musik, 'Drogerie' AS Drogerie, 'Spielwaren' AS Spielwaren))
--WHERE kundenalter != 'Alle'
ORDER BY kundenalter;


-- aufgabe 4 
SELECT floor(months_between(sysdate,vk.geburtsdatum)/12) AS vk_alter ,EXTRACT (YEAR FROM v.datum) AS verkaufsjahr,
p.produktgruppe AS produktgruppe, sum((v.anzahl) *  p.preis) AS Umsatz
FROM verkaeufe v, verkaeufer vk, produkte p
WHERE v.vk_id = vk.vk_id
AND v.produkt_id = p.produkt_id
Group by Rollup (floor(months_between(sysdate,vk.geburtsdatum)/12),EXTRACT (YEAR FROM v.datum),  p.produktgruppe);

SELECT floor(months_between(sysdate,vk.geburtsdatum)/12) AS vk_alter ,EXTRACT (YEAR FROM v.datum) AS verkaufsjahr,
p.produktgruppe AS produktgruppe, sum((v.anzahl) *  p.preis) AS Umsatz
FROM verkaeufe v, verkaeufer vk, produkte p
WHERE v.vk_id = vk.vk_id
AND v.produkt_id = p.produkt_id
Group by Cube (EXTRACT (YEAR FROM v.datum) , p.produktgruppe,floor(months_between(sysdate,vk.geburtsdatum)/12));

        
    

    




