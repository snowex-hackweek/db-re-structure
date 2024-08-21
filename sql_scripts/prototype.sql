drop table if exists instruments cascade;

create table instruments as
  select distinct(instrument) as name from points_prototype;

alter table instruments
   add column id INT generated always as identity,
   add primary key(id);

select * from instruments

alter table points_prototype 
  add instrument_id INT,
  add constraint fk_instrument
  foreign key (instrument_id)
  references instruments (id);
  
insert into points_prototype (instrument_id)
  select instruments.id
  from instruments 
  join points_prototype on
  instruments.name = points_prototype.instrument;
 
 CREATE INDEX instrument_id_idx ON points_prototype (instrument_id);
 
explain select * from points_prototype as p, instruments as i
where i.name ='pulse EKKO Pro multi-polarization 1 GHz GPR';

select * from points_prototype as p left join instruments as inst
on p.instrument_id = inst.id
where inst.name ='pulse EKKO Pro multi-polarization 1 GHz GPR';

select * from points_prototype
where instrument = 'pulse EKKO Pro multi-polarization 1 GHz GPR';
