INSERT INTO ccc_development.evenements (id, description, created_at, updated_at, le, categorie, nom, type) VALUES (64, 'A renseigner.', '2012-09-12 23:32:00', '2012-09-12 23:32:00', '2012-05-05 00:00:00', 'ROUTE', 'ST ARNOULT / MAILLEBOIS / ST ARNOULT', 'Programme 2012');
use ccc_development;

TRUNCATE TABLE ccc_development.circuits;
TRUNCATE TABLE ccc_development.evenements;
TRUNCATE TABLE ccc_development.indications;
TRUNCATE TABLE ccc_development.programmations;
TRUNCATE TABLE ccc_development.rel_circuit_indications;



select
  c.description,
  c.direction,
  c.longueur,
  c.difficulte,
  i.nom
from
  rel_circuit_indications r,
  indications i,
  circuits c
where
  r.circuit_id = c.id
  and
  r.indication_id = i.id
order by
  c.description,
  r.rang;
 
 
 select
  p.id,
  c.description,
  p.le,
  concat('UPDATE programmations SET groupe='''', le=''',p.le,''' where id=',p.id,';')
 from
  programmations p,
  circuits c
where
  p.programme_id = c.id
  and
  le >= '2012-07-01'
order by
  le desc
 ;
 
 
UPDATE programmations SET groupe='C', le='2012-09-30 08:00:00' where id=258;
UPDATE programmations SET groupe='RS & R', le='2012-09-30 08:00:00' where id=427;
UPDATE programmations SET groupe='RS & R', le='2012-09-23 08:00:00' where id=435;
UPDATE programmations SET groupe='C', le='2012-09-23 08:00:00' where id=273;
UPDATE programmations SET groupe='RS & R', le='2012-09-16 08:00:00' where id=450;
UPDATE programmations SET groupe='C', le='2012-09-16 08:00:00' where id=308;
UPDATE programmations SET groupe='C', le='2012-09-09 08:00:00' where id=334;
UPDATE programmations SET groupe='RS & R', le='2012-09-09 08:00:00' where id=460;
UPDATE programmations SET groupe='RS & R', le='2012-08-26 07:30:00' where id=531;
UPDATE programmations SET groupe='C', le='2012-08-26 08:00:00' where id=420;
UPDATE programmations SET groupe='C', le='2012-08-19 08:00:00' where id=414;
UPDATE programmations SET groupe='RS & R', le='2012-08-19 07:30:00' where id=522;
UPDATE programmations SET groupe='C', le='2012-08-15 08:00:00' where id=323;
UPDATE programmations SET groupe='RS & R', le='2012-08-15 07:30:00' where id=528;
UPDATE programmations SET groupe='RS & R', le='2012-08-12 07:30:00' where id=540;
UPDATE programmations SET groupe='C', le='2012-08-12 08:00:00' where id=384;
UPDATE programmations SET groupe='RS & R', le='2012-08-05 07:30:00' where id=551;
UPDATE programmations SET groupe='C', le='2012-08-05 08:00:00' where id=401;
UPDATE programmations SET groupe='C', le='2012-07-29 08:00:00' where id=406;
UPDATE programmations SET groupe='RS & R', le='2012-07-29 07:30:00' where id=536;
UPDATE programmations SET groupe='RS & R', le='2012-07-22 07:30:00' where id=546;
UPDATE programmations SET groupe='C', le='2012-07-22 08:00:00' where id=378;
UPDATE programmations SET groupe='RS & R', le='2012-07-15 08:00:00' where id=517;
UPDATE programmations SET groupe='C', le='2012-07-15 08:00:00' where id=284;
UPDATE programmations SET groupe='C', le='2012-07-14 08:00:00' where id=341;
UPDATE programmations SET groupe='RS & R', le='2012-07-14 08:00:00' where id=478;
UPDATE programmations SET groupe='C', le='2012-07-08 08:00:00' where id=354;
UPDATE programmations SET groupe='RS & R', le='2012-07-08 08:00:00' where id=491;

 commit;
 
 select * from programmations where le >= '2012-11-01' order by le desc;
 delete from programmations where le >= '2012-11-01';
 
 delete from ccc_development.programmations where le >= '2012-10-01';
 
 update circuits set denivele=0 where denivele is null;
 
UPDATE circuits set id_openrunner = '863570' where description = '52 A';
UPDATE circuits set id_openrunner = '847032' where description = '42 A';
UPDATE circuits set id_openrunner = '828148' where description = '41 A';
UPDATE circuits set id_openrunner = '820847' where description = '36 A';
UPDATE circuits set id_openrunner = '805843' where description = '26 A';
UPDATE circuits set id_openrunner = '799292' where description = '25 B';
UPDATE circuits set id_openrunner = '1804044' where id_openrunner is null;

select * from circuits where description like '52%';UPDATE evenements SET description = 'Salle polyvalente d’Oncy
91 *Oncy sur Ecole*
De 08h00 à 10h30 - Clôture: 13h30
VTT : 16 / 25 / 35 / 45 / 55 Km
Tarifs:   L: 4,00 &euro;
         NL: 6,00 &euro;
 -18 ans NL: 6,00 &euro;
91 - 06485
[ONCY NOISY CYCLO CLUB](http://oncc.chez.com/)' WHERE id = 63;
UPDATE evenements SET description = 'Salle polyvalente d’Oncy\n91 **Oncy sur Ecole**\nDe 08h00 à 10h30 - Clôture: 13h30\nVTT : 16 / 25 / 35 / 45 / 55 Km\nTarifs:\n*   L: 4,00 &euro;\n*   NL: 6,00 &euro;\n*   -18 ans NL: 6,00 &euro;\n91 - 06485\n[ONCY NOISY CYCLO CLUB](http://oncc.chez.com/)' WHERE id = 63;;


alter table evenements modify description varchar(1024);

select programme_type,programme_id,count(*) from programmations group by programme_type,programme_id;

select * from circuits where id=36;

select * from programmations where programme_id=36;

use ccc_development;
update users set emailccc='ccc.thiher.739619@gmail.com', licence='739619' where id=1;
update users set emailccc='ccc.danmau.174646@gmail.com', licence='174646' where id=2;
update users set emailccc='ccc.patcoc.725257@gmail.com', licence='725257' where id=3;
update users set emailccc='ccc.armmar.331328@gmail.com', licence='331328' where id=4;
commit;
