drop table if exists instruments cascade;

create table instruments as
  select distinct(instrument) as name from points_prototype;

alter table instruments
   add column id INT generated always as identity,
   add primary key(id);

select * from instruments

-- run only to recreate the points_prototype table:
-- create table points_prototype as select * from points_original;

-- create the foreign key
alter table points_prototype 
  add instrument_id INT,
  add constraint fk_instrument
  foreign key (instrument_id)
  references instruments (id);

-- populate with indices from the instruments table
update points_prototype
set instrument_id = instruments.id from instruments
where points_prototype.instrument = instruments.name;
 
 -- create index for faster searching
 CREATE INDEX instrument_id_idx ON points_prototype (instrument_id);
 
explain select * from points_prototype as p left join instruments as inst
on p.instrument_id = inst.id
where inst.name ='pulse EKKO Pro multi-polarization 1 GHz GPR';

explain select * from points_prototype
where instrument = 'pulse EKKO Pro multi-polarization 1 GHz GPR';
