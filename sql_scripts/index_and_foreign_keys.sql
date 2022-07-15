--create extension postgis;

drop table if exists instruments cascade;

drop table if exists sites cascade;

drop table if exists pubref cascade;

drop table if exists vegclass cascade;

drop table if exists observers cascade;

drop table if exists points cascade;

drop table if exists samples cascade;

drop table if exists layers cascade;

drop table if exists sample_types cascade;

drop table if exists samples_observers cascade;

drop table if exists points_observers cascade;

create table instruments(
        id serial primary key,
        name varchar(80)
       );

create table sites(
        id serial primary key,
        name varchar(80),
        geom geometry
       );

create table pubref(
        id serial primary key,
        doi varchar(80));

create table vegclass(
       id serial primary key,
       type varchar(80)
);

create table observers(
       id serial primary key,
       name varchar(80)
);

create table points(
        id serial primary key,
        inst_id int references instruments(id),
        site_id int references sites(id),
        pubref_id int references pubref(id)
);

create table samples(
        id serial primary key,
        type varchar(80),
        value float,
        uncertainty float,
        vegclass_id int references vegclass(id)
);

create table sample_types(
	id serial primary key,
	name varchar(80),
	unit varchar(80)
);

create table layers(
        id serial primary key,
        site_id int references sites(id),
        sample_types_id int references sample_types(id),
        sample_id int references samples(id)
);


-- JOIN tables for many to many relationships

create table points_observers(
	points_id int references points(id),
	observer_id int references observers(id)
);

create table samples_observers(
	observers_id int references observers(id),
	samples_id int references samples(id)
);

-- Index to use for searching
DROP INDEX IF EXISTS points_inst_id_idx CASCADE;
DROP INDEX IF EXISTS layers_site_id_idx CASCADE;
DROP INDEX IF EXISTS samples_vegclass_id_idx CASCADE;

DROP INDEX IF EXISTS points_observers_points_id_idx CASCADE;
DROP INDEX IF EXISTS samples_observers_observers_id_idx CASCADE;

CREATE INDEX points_inst_id_idx ON public.points (inst_id,site_id);
CREATE INDEX layers_site_id_idx ON public.layers (site_id,sample_id);
CREATE INDEX samples_vegclass_id_idx ON public.samples (vegclass_id);

CREATE UNIQUE INDEX points_observers_points_id_idx ON public.points_observers (points_id,observer_id);
CREATE UNIQUE INDEX samples_observers_observers_id_idx ON public.samples_observers (observers_id,samples_id);

