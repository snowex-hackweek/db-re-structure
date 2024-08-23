DROP TABLE IF EXISTS instruments;
drop table if exists points_prototype;

create table instruments as
  select distinct(instrument) from points;
 
alter table instruments
   add column id INT generated always as identity,
   add primary key(id);

create table points_prototype as 
   select instrument, latitude, longitude from points;
  
alter table points_prototype 
  add instrument_id INT,
  add constraint fk_instrument
  foreign key (instrument_id)
  references instruments (id);
  
insert into points_prototype (instrument_id)
  select id
  from instruments 
  join points_prototype on
  instruments.id = points_prototype.instrument_id;
 
