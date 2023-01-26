CREATE TABLE girokonto (
 name VARCHAR2(20) primary key,
 kontostand INT,
 land VARCHAR2(20)
 );
GRANT INSERT, SELECT, UPDATE ON girokonto TO dbsys84;
INSERT INTO girokonto VALUES ('A', 1000, 'D');
INSERT INTO girokonto VALUES ('B', 1000, 'D');
INSERT INTO girokonto VALUES ('C', 1000, 'D');
INSERT INTO girokonto VALUES ('D', 1000, 'D');
INSERT INTO girokonto VALUES ('E', 1000, 'D');
INSERT INTO girokonto VALUES ('F', 1000, 'CH');
INSERT INTO girokonto VALUES ('G', 1000, 'CH');
INSERT INTO girokonto VALUES ('H', 1000, 'CH');
INSERT INTO girokonto VALUES ('I', 1000, 'CH');
INSERT INTO girokonto VALUES ('J', 1000, 'CH');
COMMIT;


SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT SUM(kontostand) FROM dbsys64.girokonto
WHERE land = 'D';

UPDATE dbsys64.girokonto SET kontostand = kontostand - 500 WHERE 
name = 'A';
UPDATE dbsys64.girokonto SET kontostand = kontostand + 500 WHERE 
name = 'F';

SELECT SUM(kontostand) FROM dbsys64.girokonto
WHERE land = 'CH';

COMMIT;




--ALTER SESSION SET ISOLATION_LEVEL SERIALIZABLE;