----------------------------------------------------------------------------------------
-- A Database of Ice and Fire
--
-- (SQL statements for Liam Harwood's Database Systems Final Project)
-- 
-- by Liam Harwood
-- 
-- Tested on Postgres 9.5
----------------------------------------------------------------------------------------

/*
 *
 * TABLES AND SAMPLE DATA
 *
 */

--
-- People Table
--

drop table if exists People;

create table People (
   pid       integer not null,
   name      text    not null,
   gender    char(1) not null check(gender='m' or gender='f'),
   birthyear integer not null,
   deathyear integer,
  primary key(pid)
);

insert into People (pid, name, gender, birthyear, deathyear) values
    (1,  'Eddard Stark',       'm', 263, 299),
    (2,  'Robb Stark',         'm', 283, 299),
    (3,  'Catelyn Stark',      'f', 264, 299),
    (4,  'Sansa Stark',        'f', 286, null),
    (5,  'Arya Stark',         'f', 289, null),
    (6,  'Euron Greyjoy',      'm', 267, null),
    (7,  'Tyrion Lannister',   'm', 273, null),
    (8,  'Tywin Lannister',    'm', 242, 300),
    (9,  'Jaime Lannister',    'm', 266, null),
    (10, 'Cersei Lannister',   'f', 266, null),
    (11, 'Daenerys Targaryen', 'f', 284, null),
    (12, 'Robert Baratheon',   'm', 262, 298),
    (13, 'Stannis Baratheon',  'm', 264, null),
    (14, 'Joffrey Baratheon',  'm', 286, 300),
    (15, 'Jon Snow',           'm', 283, null),
    (16, 'Davos Seaworth',     'm', 260, null),
    (17, 'Brienne of Tarth',   'f', 280, null),
    (18, 'Samwell Tarly',      'm', 283, null),
    (19, 'Oberyn Martell',     'm', 257, 300),
    (20, 'Doran Martell',      'm', 247, null),
    (21, 'Theon Greyjoy',      'm', 278, null),
    (22, 'Balon Grejoy',       'm', 250, 299),
    (23, 'Tommen Baratheon',   'm', 291, null),
    (24, 'Edmure Tully',       'm', 270, null);

select * from People;

--
-- Kings Table
--

drop table if exists Kings;

create table Kings (
   pid            integer not null references People(pid),
   title          text    not null,
   reignstartyear integer not null,
   reignendyear   integer,
  primary key(pid)
);

insert into Kings (pid, title, reignstartyear, reignendyear) values
    (2, 'The King in the North', 299, 299),
    (6, 'Iron King of the Isles and the North', 299, null),
    (12, 'King of the Andals, the Rhoynar and the First Men', 283, 298),
    (13, 'The King in the Narrow Sea', 299, 299),
    (14, 'King of the Andals, the Rhoynar and the First Men', 298, 300),
    (22, 'Iron King of the Isles and the North', 299, 299),
    (23, 'King of the Andals, the Rhoynar and the First Men', 300, null);
      
select * from Kings;

--
-- NightsWatchMen Table
--

drop table if exists NightsWatchMen;

create table NightsWatchMen (
   pid integer not null references People(pid),
   job text    check(job='ranger' or job='steward' or job='builder'),
  primary key(pid)
);

insert into NightsWatchMen (pid, job) values
    (15, 'steward'),
    (18, 'steward');
    
select * from NightsWatchMen;

--
-- Knights Table
--

drop table if exists Knights;

create table Knights (
   pid  integer not null references People(pid),
   type text,
  primary key(pid)
);

insert into Knights (pid, type) values
    (9,  'Kingsguard'),
    (12, 'Landed knight'),
    (16, 'Landed knight'),
    (19, 'Landed knight'),
    (24, 'Landed knight');
    
select * from Knights;

--
-- Regions Table
--

drop table if exists Regions;

create table Regions (
   rid         integer not null,
   name        text    not null,
   description text    not null,
  primary key(rid)
);

insert into Regions (rid, name, description) values
    (1,   'The North',    'Cold and snowy'),
    (2,   'Iron Islands', 'Cold and salty'),
    (3,   'Riverlands',   'Wet and soggy'),
    (4,   'The Vale',     'High and hilly'),
    (5,   'Westerlands',  'Flat and Lannistery'),
    (6,   'Crownlands',   'Flat and kingy'),
    (7,   'The Reach',    'West and flowery'),
    (9,   'Stormlands',   'Harsh and stormy'),
    (10,  'Dorne',        'Hot and sandy'),
    (11,  'The Wall',     'Cold and spooky');
    
select * from Regions;

--
-- Castles Table
--

drop table if exists Castles;

create table Castles (
   cid  integer not null,
   name text    not null,
   rid  integer not null references Regions(rid),
  primary key(cid)
);

insert into Castles (cid, name, rid) values
    (1,  'Winterfell',    1),
    (2,  'Casterly Rock', 5),
    (3,  'Dragonstone',   9),
    (4,  'Pyke',          2),
    (5,  'Sunspear',      10),
    (6,  'Riverrun',      3),
    (7,  'Harrenhal',     3),
    (8,  'Castle Black',  11),
    (9,  'Summerhall',    9),
    (10,  'Red Keep',     6);
    

select * from Castles;

--
-- Houses Table
--

drop table if exists Houses;

create table Houses (
   hid    integer not null,
   name   text    not null,
   words  text,
   coatofarms  text,
   seatid    integer references Castles(cid),
   lordid integer references People(pid),
  primary key(hid)
);

insert into Houses (hid, name, words, coatofarms, seatid, lordid) values
    (1, 'Stark',                        'Winter is Coming',          'Direwolf',      1,    null),
    (2, 'Lannister',                    'Hear Me Roar',              'Lion',          2,    10),
    (3, 'Baratheon of Dragonstone',     'Ours is the Fury',          'Flaming Stag',  3,    13),
    (4, 'Greyjoy',                      'We Do Not Sow',             'Kraken',        4,    6),
    (5, 'Martell',                      'Unbowed, Unbent, Unbroken', 'Sun and spear', 5,    20),
    (6, 'Tully',                        'Family, Duty, Honor',       'Trout',         6,    24),
    (7, 'Targaryen',                    'Fire and Blood',            'Dragon',        null, 11),
    (8, 'Baratheon of King''s Landing', 'Ours is the Fury',          'Stag and lion', 10,   23);

select * from Houses;

--
-- Aliases Table
--

drop table if exists Aliases;

create table Aliases (
   pid  integer not null references People(pid),
   name text    not null,
  primary key(pid, name)
);

insert into Aliases (pid, name) values
    (2, 'The Young Wolf'),
    (3, 'Lady Stoneheart'),
    (4, 'Alayne Stone'),
    (5, 'Arry'),
    (5, 'Nymeria'),
    (5, 'Cat of the Canals'),
    (6, 'Crow''s Eye'),
    (7, 'The Imp'),
    (7, 'Halfman'),
    (7, 'Yollo'),
    (9, 'Kingslayer'),
    (11, 'Stormborn'),
    (11, 'Mother of Dragons'),
    (12, 'The Usurper'),
    (15, '998th Lord Commander of the Night''s Watch'),
    (16, 'Onion Knight'),
    (17, 'The Maid of Tarth'),
    (17, 'Brienne the Beauty'),
    (18, 'Sam the Slayer'),
    (19, 'The Red Viper'),
    (21, 'Reek');

select * from Aliases;

--
-- Allegiance Table
--

drop table if exists Allegiance;

create table Allegiance (
   pid  integer not null references People(pid),
   hid  integer not null references Houses(hid),
   type text    check(type='marital' or type='familial' or type='sworn'),
  primary key(pid, hid)
);

insert into Allegiance (pid, hid, type) values
    (1,  1, 'familial'),
    (2,  1, 'familial'),
    (3,  1, 'marital'),
    (4,  1, 'familial'),
    (5,  1, 'familial'),
    (15, 1, 'familial'),
    (17, 1, 'sworn'),
    (7,  2, 'familial'),
    (8,  2, 'familial'),
    (9,  2, 'familial'),
    (10, 2, 'familial'),
    (14, 2, 'familial'),
    (23, 2, 'familial'),
    (13, 3, 'familial'),
    (16, 3, 'sworn'),
    (6,  4, 'familial'),
    (21, 4, 'familial'),
    (22, 4, 'familial'),
    (19, 5, 'familial'),
    (20, 5, 'familial'),
    (3,  6, 'familial'),
    (17, 6, 'sworn'),
    (24, 6, 'familial'),
    (11, 7, 'familial'),
    (10, 8, 'marital'),
    (12, 8, 'familial'),
    (14, 8, 'familial'),
    (23, 8, 'familial');

select * from Allegiance;

--
-- Wars Table
--

drop table if exists Wars;

create table Wars (
   wid        integer not null,
   name       text    not null,
   startyear  integer not null,
   endyear    integer,
  primary key(wid)
);

insert into Wars (wid, name, startyear, endyear) values
    (1,  'War of the Five Kings',      298, 300),
    (2,  'Robert''s Rebellion',        282, 283),
    (3,  'Conflict Beyond the Wall',   296, null),
    (4,  'War of the Ninepenny Kings', 260, 260);
    
select * from Wars;

--
-- Factions Table
--

drop table if exists Factions;

create table Factions (
   fid         integer  not null,
   wid         integer  not null references Wars(wid),
   name        text     not null,
   wonwar      boolean,
  primary key(fid)
);

insert into Factions (fid, wid, name, wonwar) values
    (1,  3, 'The Night''s Watch',                    null),
    (2,  3, 'Wildlings',                             null),
    (3,  3, 'The Others',                            null),
    (4,  2, 'Rebels',                                true),
    (5,  2, 'Royalists',                             false),
    (6,  1, 'The King on the Iron Throne',           true),
    (7,  1, 'The King in the North and the Trident', false),
    (8,  1, 'The King in the Narrow Sea',            false),
    (9,  1, 'The King in Highgarden',                false),
    (10, 1, 'The King of the Isles and the North',   false),
    (11, 4, 'Seven Kingdoms',                        true),
    (12, 4, 'Band of Nine',                          false);
    
select * from Factions;

--
-- AlliedWith Table
--

drop table if exists AlliedWith;

create table AlliedWith (
   hid integer not null references Houses(hid),
   fid integer not null references Factions(fid),
  primary key(hid, fid)
);

insert into AlliedWith(hid,fid) values
    (3, 1),
    (8, 4),
    (1, 4),
    (6, 4),
    (4, 4),
    (2, 4),
    (7, 5),
    (5, 5),
    (2, 6),
    (8, 6),
    (1, 7),
    (6, 7),
    (3, 8),
    (4, 10),
    (7, 11);
    
select * from AlliedWith;

--
-- Battles Table
--

drop table if exists Battles;

create table Battles (
   bid  integer not null,
   wid  integer not null references Wars(wid),
   rid  integer not null references Regions(rid),
   name text    not null,
  primary key(bid)
);

insert into Battles (bid, wid, rid, name) values
    (1,  1, 3, 'Battle Near the Golden Tooth'),
    (2,  1, 3, 'Battle Near Riverrun'),
    (3,  1, 3, 'Battle on the Green Fork'),
    (4,  1, 3, 'Battle in the Whispering Wood'),
    (5,  1, 3, 'Battle of the Camps'),
    (6,  1, 1, 'Battle at Winterfell'),
    (7,  1, 5, 'Battle of Oxcross'),
    (8,  1, 9, 'Siege of Storm''s End'),
    (9,  1, 6, 'Battle of the Blackwater'),
    (10, 1, 3, 'The Red Wedding'),
    (11, 2, 3, 'Battle of the Trident'),
    (12, 2, 6, 'Sack of King''s Landing'),
    (13, 2, 10, 'Tower of Joy'),
    (14, 3, 11, 'Fight at the Fist'),
    (15, 3, 11, 'Battle of Castle Black');
    
select * from Battles;

--
-- Combatants Table
--

drop table if exists Combatants;

create table Combatants (
   bid       integer not null references Battles(bid),
   fid       integer not null references Factions(fid),
   wonbattle boolean,
  primary key(bid, fid)
);

insert into Combatants (bid, fid, wonbattle) values
    (1, 6, true),
    (1, 7, false),
    (2, 6, true),
    (2, 7, false),
    (3, 6, true),
    (3, 7, false),
    (4, 6, false),
    (4, 7, true),
    (5, 6, false),
    (5, 7, true),
    (6, 6, true),
    (6, 7, false),
    (6, 10, false),
    (7, 6, false),
    (7, 7, true),
    (8, 8, true),
    (8, 9, false),
    (9, 8, false),
    (9, 6, true),
    (10, 7, false),
    (10, 6, true),
    (11, 4, true),
    (11, 5, false),
    (12, 4, true),
    (12, 5, false),
    (13, 4, true),
    (13, 5, false),
    (14, 1, false),
    (14, 3, true),
    (15, 1, true),
    (15, 2, false);
    
select * from Combatants;

--
-- FoughtIn Table
--

drop table if exists FoughtIn;

create table FoughtIn (
   bid  integer not null references Battles(bid),
   pid  integer not null references People(pid),
   fid  integer not null references Factions(fid),
   died boolean not null,
  primary key(pid, bid)
);

insert into FoughtIn(bid, pid, fid, died) values
    (1,  9,  6,  false),
    (2,  9,  6,  false),
    (2,  24, 7,  false),
    (3,  8,  6,  false),
    (4,  2,  7,  false),
    (4,  9,  6,  false),
    (5,  2,  7,  false),
    (6,  21, 10, false),
    (7,  2,  7,  false),
    (8,  13, 8,  false),
    (8,  16, 8,  false),
    (9,  13, 8,  false),
    (9,  16, 8,  false),
    (9,  7,  6,  false),
    (9,  8,  6,  false),
    (10, 2,  7,  true),
    (10, 3,  7,  true),
    (10, 24, 7,  false),
    (11, 1,  4,  false),
    (11, 12, 4,  false),
    (12, 8,  4,  false),
    (12, 9,  4,  false),
    (12, 1,  4,  false),
    (13, 1,  4,  false),
    (14, 15, 1,  false),
    (14, 18, 1,  false),
    (15, 15, 1,  false),
    (15, 18, 1,  false),
    (15, 13, 1,  false),
    (15, 16, 1,  false);        
    
select * from FoughtIn;

/*
 *
 * VIEWS
 *
 */

--
-- LivingKings View
--

drop view if exists LivingKings;

create view LivingKings as
  select name, title
  from people p inner join kings k on p.pid = k.pid
  where deathyear    is null
    and reignendyear is null
  order by name asc;

select * from LivingKings;

--
-- BattleExperience View
--

drop view if exists BattleExperience;

create view BattleExperience as
  select p.name as person, w.name as war, b.name as battle, fa.name as faction
  from   people p inner join foughtin fi on p.pid  = fi.pid
		  inner join factions fa on fi.fid = fa.fid
	       	  inner join battles  b  on fi.bid = b.bid
	       	  inner join wars     w  on b.wid  = w.wid
  order by person asc;

select * from BattleExperience;

--
-- HouseWarHistory View
--

drop view if exists HouseWarHistory;

create view HouseWarHistory as
  select h.name as house, w.name as war, f.name as faction
  from houses h inner join alliedwith a on h.hid = a.hid
                inner join factions   f on a.fid = f.fid
                inner join wars       w on f.wid = w.wid
  order by house asc;

select * from HouseWarHistory;

--
-- Fealty View
--

drop view if exists Fealty;

create view Fealty as
  select p1.name as person, p2.name as lord
  from people p1 inner join allegiance a  on p1.pid   = a.pid
                 inner join houses     h  on a.hid    = h.hid
                 inner join people     p2 on h.lordid = p2.pid
  where p1.pid       != p2.pid
    and p1.deathyear is null
  order by lord asc;

select * from Fealty;

/*
 *
 * INTERESTING QUERIES AND REPORTS
 *
 */

--
-- Query for showing the numbers of wars won by each house
--

select h.name as house, count(h.hid) as warsWon
from houses h inner join alliedwith a on h.hid = a.hid
              inner join factions   f on a.fid = f.fid
where f.wonwar = true
group by h.name
order by warsWon desc;

--
-- Query for showing the length in years of each king's reign
--

select p.name, 
       case when coalesce((k.reignendyear - k.reignstartyear), (300 - reignstartyear)) = 0 then 1
            else coalesce((k.reignendyear - k.reignstartyear), (300 - reignstartyear))
       end as reignlengthyears
from people p inner join kings k on p.pid = k.pid
order by reignlengthyears desc;

--
-- Query for showing the allegiance of each person as well as their assumed aliases
--

select p.name, coalesce(a1.name, '(no aliases)') as alias, h.name
from people p left outer join aliases    a1 on p.pid  = a1.pid
              inner join      allegiance a2 on p.pid  = a2.pid
              inner join      houses     h  on a2.hid = h.hid
order by p.name;


/*
 *
 * STORED PROCEDURES
 *
 */

--
-- percentBattlesWon Function
--

create or replace function percentBattlesWon(factionName text)
returns table(percent_won numeric, wonwar boolean) as
$$
begin
  return query
  select trunc (
           (cast(
                 ( select count(c.fid) as battleswon
                   from combatants c inner join factions f on c.fid = f.fid
                                     inner join wars     w on w.wid = f.wid
                   where f.name      = factionName
                     and c.wonbattle = true
                 ) as decimal(5,2))
                     /
                     ( select count(c.fid) as battlesfought
                       from combatants c inner join factions f on c.fid = f.fid
                                         inner join wars     w on w.wid = f.wid
                       where f.name = factionName
                     ) * 100) , 2
             ) as percent_won, factions.wonwar
  from factions
  where name = factionName;
end;
$$
language plpgsql;

select percentBattlesWon('The King in the North and the Trident');

--
-- endWar Function
--
               
create or replace function endWar() returns trigger as
$$
declare
-- Unfortunately, the Westerosi calendar is not supported by Postgres, necessitating the following variable:
  currentYear integer := 300; 
begin
  if new.wonwar = true 
  and (select endyear
       from wars
       where wid = new.wid) is null
  then
      update Wars
      set endyear = currentYear
      where wid = new.wid;
  end if;
  return new;
end;
$$
language plpgsql;

--
-- endReign Function
--

create or replace function endReign() returns trigger as
$$
begin
  if  new.deathyear is not null
  and (select reignendyear 
       from kings 
       where pid = new.pid) is null
  then
      update kings
      set reignendyear = new.deathyear
      where pid = new.pid;  
  end if;
  return new;
end;
$$
language plpgsql;

/*
 *
 * TRIGGERS
 *
 */

--
-- endWar Trigger
--

create trigger endWar
after update on Factions
for each row
execute procedure endWar();

/*
TEST QUERIES

select * from factions where name = 'The Night''s Watch';
select * from wars where name = 'Conflict Beyond the Wall';

update factions
set wonwar = true
where name = 'The Night''s Watch';

update wars
set endyear = null
where name = 'Conflict Beyond the Wall';
*/

--
-- endReign Trigger
--

create trigger endReign
after update on People
for each row
execute procedure endReign();

/*
TEST QUERIES

select * from people where name = 'Euron Greyjoy';
select * from kings where pid = 6;

update people
set deathyear = 300
where name = 'Euron Greyjoy';

update kings
set reignendyear = null
where pid = 6;

*/     

/*
 *
 * SECURITY
 *
 */

--
-- Administrator
--

create role admin;
grant all on all tables in schema public to admin;

--
-- Maester
--

create role maesters;
revoke all on all tables in schema public from maesters;
grant select on all tables in schema public to maesters;
grant insert on people, kings, nightswatchmen, knights,
                aliases, houses, allegiance, foughtin,
                battles, wars, combatants, factions,
                alliedwith
to maesters;
grant update on people, kings, nightswatchmen, knights,
                aliases, houses, allegiance, foughtin,
                battles, wars, combatants, factions,
                alliedwith
to maesters;

--
-- Visitor
--

create role visitors;
revoke all on all tables in schema public from visitors;
grant select on people, kings, nightswatchmen, knights,
                houses, castles, regions, foughtin,
                battles, wars, combatants, factions, 
                alliedwith
to visitors;
                

