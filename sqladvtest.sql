select C.algorithm,
    (select sum(tmp.vol)
    from(select volume as vol, algorithm
    from transactions as t
    inner join coins as c on c.code = t.coin_code
    where month(dt) between 1 and 3 and year(dt) = 2020
    and C.algorithm = c.algorithm 
    group by volume, algorithm
    )tmp where tmp.algorithm = C.algorithm)as q1
    ,
    (select sum(tmp.vol)
    from(select volume as vol, algorithm
    from transactions as t
    inner join coins as c on c.code = t.coin_code
    where month(dt) between 4 and 6 and year(dt) = 2020
    and C.algorithm = c.algorithm 
    group by volume, algorithm
    )tmp where tmp.algorithm = C.algorithm)as q2,
    (select sum(tmp.vol)
    from(select volume as vol, algorithm
    from transactions as t
    inner join coins as c on c.code = t.coin_code
    where month(dt) between 7 and 9 and year(dt) = 2020
    and C.algorithm = c.algorithm 
    group by volume, algorithm
    )tmp where tmp.algorithm = C.algorithm)as q3,
    (select sum(tmp.vol)
    from(select volume as vol, algorithm
    from transactions as t
    inner join coins as c on c.code = t.coin_code
    where month(dt) between 10 and 12 and year(dt) = 2020
    and C.algorithm = c.algorithm 
    group by volume, algorithm
    )tmp where tmp.algorithm = C.algorithm)as q4
 
from coins as C
group by algorithm, q1, q2, q3, q4
order by algorithm

