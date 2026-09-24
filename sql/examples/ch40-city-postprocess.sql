-- Chapter 40: Local Post Processing of the City Lookup report (page 21)
select name,
       admin1       as state_or_province,
       country,
       population,
       latitude,
       longitude,
       timezone
  from #APEX$SOURCE_DATA#
 where country_code in ('US', 'CA')
 order by population desc nulls last
