select concat(substr(dt.dtc::date::text, 0, 8), '-01')::date as date,
        (select count(*)
        from posts as p
        where EXTRACT(day from created_at) between 1 and 31
        and EXTRACT(month from dt.dtc) = EXTRACT(month from p.created_at)
        and EXTRACT(year from dt.dtc) = EXTRACT(year from p.created_at)) as count,
        
         (select to_char(round( (to_char((((cast(tmp.ct1 as float) / cast(tmp.ct2 as float)) - 1.0)*100 ), 'FM999999999.00'))::numeric, 1)::float, 'FM999999999.0%')
        from(select 
          (select count(*) as cnt
        from posts as p
        where EXTRACT(day from created_at) between 1 and 31
        and EXTRACT(month from dt.dtc) = EXTRACT(month from p.created_at)
        and EXTRACT(year from dt.dtc) = EXTRACT(year from p.created_at)
          group by dt.dtc) as ct1,
         (select count(*) as cnt
        from posts as p
        where EXTRACT(day from created_at) between 1 and 31
        and  EXTRACT(month from p.created_at::DATE) = EXTRACT(month from(dt.dtc::DATE - interval '1 month')::DATE)
        and EXTRACT(year from p.created_at::DATE) = EXTRACT(year from(dt.dtc::DATE - interval '1 month')::DATE)
        group by dt.dtc                                                     
        ) as ct2
        )tmp) as percent_growth
        
from(select created_at::DATE  as dtc
        from posts as p
        where EXTRACT(day from created_at) = (select  min(EXTRACT(day from created_at))
                                              from posts as p2
                                              where DATE_TRUNC('month', p.created_at)=DATE_TRUNC('month', p2.created_at))
                                              
        group by created_at::DATE
        ) as dt
    
group by date, dt.dtc, count
order by date
        
        
        