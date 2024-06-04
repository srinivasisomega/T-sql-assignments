WITH cte AS (
    SELECT id,name,service_type, age, dbo.age(date_of_join,GETDATE()) as 'service_status',
        row_number() OVER (partition by service_type ORDER BY age) rnk_min,
        row_number() OVER (partition by service_type ORDER BY age DESC) rnk_max
    FROM company_bonus
)
SELECT id,name,service_type, age,service_status
FROM cte
WHERE rnk_min = 1 OR rnk_max = 1
ORDER BY service_type,age;