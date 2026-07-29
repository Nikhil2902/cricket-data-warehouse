select * from cricket.clean.match_detail_clean
where match_type_number = 4686;

select  
  country,
  batter,
  sum(runs)
from
  cricket.clean.delivery_clean_tbl
where match_type_number = 4686
group by country, batter
order by 1,2,3 desc;

