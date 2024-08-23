-- Instruments
drop table if exists instruments cascade;

create table instruments as
  select distinct(instrument) as name from points_original;

alter table instruments
   add column id INT generated always as identity,
   add column model VARCHAR(255),
   add column specifications VARCHAR(255),
   add primary key(id);

-- Observers
drop table if exists observers cascade;
create table observers as
  select distinct(observers) as name from points_original;

alter table observers
   add column id INT generated always as identity,
   add column first_name VARCHAR(255),
   add column last_name VARCHAR(255),
   add column email VARCHAR(255),
   add primary key(id);

-- run only to recreate the points_prototype table:
drop table if exists points_prototype cascade;
create table points_prototype as select * from points_original;
-- create the foreign keys:
alter table points_prototype 
  add instrument_id INT,
  add observer_id INT,
  add constraint fk_instrument
  foreign key (instrument_id)
  references instruments (id),
  add constraint fk_observer
  foreign key (observer_id)
  references observers (id);

-- populate with indices from the instruments table
update points_prototype
set instrument_id = instruments.id from instruments
where points_prototype.instrument = instruments.name;
 
update points_prototype
set observer_id = observers.id from observers
where points_prototype.observers = observers.name;
 
 -- create indexes for faster searching
CREATE INDEX instrument_id_idx ON points_prototype (instrument_id);
CREATE INDEX observer_id_idx ON points_prototype (observer_id);
 
-- drop the columns we no longer need and put in a new table
create table points_cleaned as
  select * FROM points_prototype;

ALTER TABLE points_cleaned
DROP COLUMN observers,
DROP COLUMN instrument;  

VACUUM (ANALYZE) points_cleaned;

-- three ways to run queries with combined observer and instrument where clauses:

EXPLAIN (ANALYZE, TIMING FALSE) select count(*) from (
select * from points_cleaned as p left join instruments as inst
on p.instrument_id = inst.id
where inst.name ='pulse EKKO Pro multi-polarization 1 GHz GPR') as iii
left join observers as obs
on iii.observer_id = obs.id
where obs.name = 'Randall Bonnell';

EXPLAIN (ANALYZE, TIMING FALSE) SELECT count(*) FROM points_cleaned
WHERE instrument_id =
(SELECT id from instruments as inst where inst.name = 'pulse EKKO Pro multi-polarization 1 GHz GPR')
AND observer_id = 
(SELECT id from observers as obs where obs.name = 'Randall Bonnell')

EXPLAIN (ANALYZE, TIMING FALSE) select count(*) from points_prototype
where instrument = 'pulse EKKO Pro multi-polarization 1 GHz GPR'
and observers = 'Randall Bonnell';
