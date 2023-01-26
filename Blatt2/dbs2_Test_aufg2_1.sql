select * from dbsys70.myself;
select * from dbsys70.mypers;

--aenderung des eigenen namens erfolgreich
update dbsys70.myself
set name = 'test'
where pnr=123;



--aenderung eigenes gehalt endet in "insufficient privileges"
update dbsys70.myself
set gehalt = '100000'
where pnr=123;



--aenderung von namen des angestellten endet in "insufficient privileges"
update dbsys70.mypers
set name = 'test'
where pnr = 406;

--aenderung des gehalts von angestellen  erfolgreich
update dbsys70.mypers
set gehalt = 90000
where pnr=406;

select * from dbsys70.myself;
select * from dbsys70.mypers;


commit;
