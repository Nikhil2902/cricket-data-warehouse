-- Clean zone: extract elements from innings array using lateral flatten
-- Co-authored with CoCo
use role sysadmin;
use warehouse compute_wh;
use schema cricket.clean;

--version-1 extract elements from innnigs array
select 
  m.info:match_type_number::int as match_type_number,
  m.innings
from cricket.raw.match_raw_tbl m
where match_type_number = 4674;

--v2 
select
  m.info:match_type_number::int as match_type_number,
  i.value:team::text as team_name,
  i.*
from cricket.raw.match_raw_tbl m,
lateral flatten(input => m.innings) i
where match_type_number = 4674;

--v3
select
  m.info:match_type_number::int as match_type_number,
  i.value:team::text as team_name,
  o.*
from cricket.raw.match_raw_tbl m,
lateral flatten(input => m.innings) i ,
lateral flatten(input => i.value:overs) o
where match_type_number = 4674;


select 
    m.info:match_type_number::int as match_type_number, 
    i.value:team::text as country,
    o.value:over::int as over,
    d.value:bowler::text as bowler,
    d.value:batter::text as batter,
    d.value:non_striker::text as non_striker,
    d.value:runs.batter::text as runs,
    d.value:runs.extras::text as extras,
    d.value:runs.total::text as total,
    w.value:player_out::text as player_out,
    w.value:kind::text as player_out_kind,
    w.value:fielders::variant as player_out_fielders,
    m.stg_file_name ,
    m.stg_file_row_number,
    m.stg_file_hashkey,
    m.stg_modified_ts,
    e.*,
from cricket.raw.match_raw_tbl m,
lateral flatten (input => m.innings) i,
lateral flatten (input => i.value:overs) o,
lateral flatten (input => o.value:deliveries) d,
lateral flatten (input => d.value:extras) e,
lateral flatten (input => d.value:wickets, outer => True) w;

--v6
create or replace table delivery_clean_tbl as
select 
    m.info:match_type_number::int as match_type_number, 
    i.value:team::text as country,
    o.value:over::int as over,
    d.value:bowler::text as bowler,
    d.value:batter::text as batter,
    d.value:non_striker::text as non_striker,
    d.value:runs.batter::text as runs,
    d.value:runs.extras::text as extras,
    d.value:runs.total::text as total,
    w.value:player_out::text as player_out,
    w.value:kind::text as player_out_kind,
    w.value:fielders::variant as player_out_fielders,
    m.stg_file_name ,
    m.stg_file_row_number,
    m.stg_file_hashkey,
    m.stg_modified_ts
from cricket.raw.match_raw_tbl,
lateral flatten (input => m.innings) i,
lateral flatten (input => i.value:overs) o,
lateral flatten (input => o.value:deliveries) d,
lateral flatten (input => d.value:wickets, outer => True) w;

alter table cricket.clean.delivery_clean_tbl
modify column match_type_number set not null;

alter table cricket.clean.delivery_clean_tbl
modify column country set not null;

alter table cricket.clean.delivery_clean_tbl
modify column over set not null;

alter table cricket.clean.delivery_clean_tbl
modify column bowler set not null;

alter table cricket.clean.delivery_clean_tbl
modify column batter set not null;

alter table cricket.clean.delivery_clean_tbl
modify column non_striker set not null;

-- fk relationship
alter table cricket.clean.delivery_clean_tbl
add constraint fk_delivery_match_id
foreign key (match_type_number)
references cricket.clean.match_detail_clean (match_type_number);
  
   
