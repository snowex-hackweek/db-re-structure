
drop table if exists instruments cascade;

drop table if exists measurement_types cascade;

drop table if exists measurements cascade;

drop table if exists observers cascade;

drop table if exists sites cascade;

drop table if exists points cascade;

drop table if exists layers cascade;

drop table if exists observers_points cascade;

create table instruments(
    id serial primary key,
    name varchar(80) not NULL
);

create table measurement_types(
    id serial primary key,
    name varchar(80) not NULL,
    unit varchar(80) not NULL
);

create table observers(
    id serial primary key,
    name varchar(80) not NULL
);

create table sites(
    id serial primary key,
    name varchar(50) not null
);

create table points(
    id serial primary key,
    pit_id varchar(50) not null,
    observation_date date not null,
    sites_id int references sites(id) not null
);

create table layers(
    id serial primary key,
    "depth" float8 not null,
    bottom_depth float8,
    "comments" varchar(1000),
    time_created timestamptz NULL DEFAULT now(),
    time_updated timestamptz NULL,
    flags varchar(20) null,
    points_id int references points(id) not null
);

create table measurements(
    id serial primary key,
    value varchar(50) not NULL,
    profile_identifier char(1),
    uncertainty float8,
    layers_id int references layers(id) not NULL,
    measurement_types_id int references measurement_types(id) not NULL,
    instruments_id int references instruments(id) not NULL
);

-- JOIN tables for many to many relationships

create table observers_points(
    points_id int references points(id) not NULL,
    observers_id int references observers(id) not NULL
);

-- Index to use for searching
DROP INDEX IF EXISTS layer_measurements_instruments_idx CASCADE;
DROP INDEX IF EXISTS points_sites_idx cascade;
DROP INDEX IF EXISTS points_observers_idx CASCADE;

CREATE INDEX layer_measurements_instruments_idx ON 
  measurements (layers_id, measurement_types_id, instruments_id);
CREATE INDEX points_sites_idx ON points (sites_id);
  
CREATE UNIQUE INDEX points_observers_idx ON 
  observers_points (points_id, observers_id);


