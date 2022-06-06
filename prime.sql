DELIMITER |
create procedure prime1000()
BEGIN
DECLARE i INT;
declare x int;
declare p int;
declare f varchar(10000);
set f = "";
set i = 2;
while i <= 1000 do
    set x = 2;
    set p = 1;
    not_prime: while x*x <= i do
        if mod(i, x) = 0 then
            set p = 0;
            leave not_prime;
        end if;
        set x = x + 1;
    end while not_prime;
    if p = 1 then
        set f = concat(f,i,"&");
    end if;
    set i = i + 1;
end while;
select substr(f, 1, length(f)-1);
END;
call prime1000();
|