-- DROP VIEW IF EXISTS forestation;
-- CREATE VIEW forestation AS (
-- 	SELECT
-- 		f.country_code,
-- 		f.year,
-- 		f.forest_area_sqkm,
-- 		l.total_area_sq_mi,
-- 		r.country_name,
-- 		r.region,
-- 		r.income_group,
-- 		f.forest_area_sqkm / (l.total_area_sq_mi * 2.59) * 100 AS forest_sqkm_percent
-- 	FROM
-- 		forest_area f
-- 		JOIN land_area l ON f.country_code = l.country_code
-- 		AND f.year = l.year
-- 		JOIN regions r ON f.country_code = r.country_code
);

-- Part -1 GLOBAL SITUATION

-- Question 1.What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.
-- SELECT ROUND(SUM(forest_area_sqkm)::numeric,2) AS forest_area_1990
-- FROM forestation
-- WHERE year = 1990 AND country_name = 'World';


-- Que.2 What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.” 
-- SELECT ROUND(SUM(forest_area_sqkm)::numeric,2) AS forest_area_2016
-- FROM forestation
-- WHERE year = 2016 AND country_name = 'World';


-- Que.3 What was the change (in sq km) in the forest area of the world from 1990 to 2016?
-- WITH forest_1990 AS (	
--          SELECT ROUND(SUM(forest_area_sqkm)::numeric,2) AS forest_area_1990
--          FROM forestation
--          WHERE year = 1990 AND Country_name = 'World'),
-- 	forest_2016 
-- 	AS (
--          SELECT ROUND(SUM(forest_area_sqkm)::numeric,2) AS forest_area_2016
--          FROM forestation
--          WHERE year = 2016 AND Country_name = 'World')
-- SELECT forest_area_1990 - forest_area_2016 AS diffrence
-- FROM forest_1990,forest_2016; 


-- Que.4 What was the percent change in forest area of the world between 1990 and 2016?
-- WITH forest_1990 AS (	
--          SELECT ROUND(SUM(forest_area_sqkm)::numeric,2) AS forest_area_1990
--          FROM forestation
--          WHERE year = 1990 AND Country_name = 'World'),
-- 	forest_2016 
-- 	AS (
--          SELECT ROUND(SUM(forest_area_sqkm)::numeric,2) AS forest_area_2016
--          FROM forestation
--          WHERE year = 2016 AND Country_name = 'World')
-- SELECT forest_area_1990 - forest_area_2016 AS diffrence, round((forest_area_2016 - forest_area_1990)*100/forest_area_1990::numeric,2) AS precentage
-- FROM forest_1990,forest_2016; 


--que.5 If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
-- WITH forest_1990 AS (
-- 	SELECT ROUND(SUM(forest_area_sqkm) :: numeric, 2) AS forest_area_1990
-- 	FROM forestation
-- 	WHERE year = 1990 AND Country_name = 'World'
-- ),
-- forest_2016 AS (
-- 	SELECT ROUND(SUM(forest_area_sqkm) :: numeric, 2) AS forest_area_2016
-- 	FROM forestation
-- 	WHERE year = 2016 AND Country_name = 'World'
-- ),
-- diff AS (
-- 	SELECT forest_area_1990, forest_area_2016, forest_area_1990 - forest_area_2016 AS diffrence
-- 	FROM forest_1990, forest_2016
-- ),
-- total_area AS (
-- 	SELECT country_name, total_area_sq_mi * 2.59 AS total_area_sqkm
-- 	FROM forestation
-- )
-- SELECT distinct round(total_area_sqkm :: numeric, 2) AS area_same, country_name
-- FROM diff, total_area
-- WHERE diffrence >= total_area_sqkm
-- ORDER BY 1 DESC
-- LIMIT 5;


-- part--2 REGIONAL OUTLOOK


-- Que.1 a. What was the percent forest of the entire world in 2016? Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?
-- SELECT region, ROUND ((SUM(forest_area_sqkm) * 100/ SUM(total_area_sq_mi * 2.59))::numeric, 2) AS percentag
-- FROM forestation
-- WHERE year = 2016
-- GROUP BY region
-- ORDER BY percentag DESC;


-- Que.2 What was the percent forest of the entire world in 1990? Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?
-- SELECT region, ROUND ((SUM(forest_area_sqkm) * 100/ SUM(total_area_sq_mi * 2.59))::numeric, 2) AS percentag
-- FROM forestation
-- WHERE year = 1990
-- GROUP BY region
-- ORDER BY percentag DESC;
-- 

-- QUE. 3 Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?
-- with fr1990 AS (
-- 	select country_name, forest_area_sqkm
-- 	from forestation
-- 	where year = 1990
-- ),
-- fr2016 AS (
-- 	select country_name, forest_area_sqkm
-- 	from forestation
-- 	where year = 2016
-- ),
-- pr1990 AS (
-- 	SELECT ROUND ((SUM(forest_area_sqkm) * 100 / SUM(total_area_sq_mi * 2.59)) :: numeric, 2) AS percentag, country_name
-- 	FROM forestation
-- 	WHERE year = 1990
-- 	GROUP BY country_name
-- ),
-- pr2016 AS (
-- 	SELECT ROUND ((SUM(forest_area_sqkm) * 100 / SUM(total_area_sq_mi * 2.59)) :: numeric,2) AS percentag, country_name
-- 	FROM forestation
-- 	WHERE year = 2016
-- 	GROUP BY country_name
-- )
-- select round((b.forest_area_sqkm - a.forest_area_sqkm) :: numeric,2) AS diff, a.country_name, d.percentag - c.percentag AS pre
-- from fr1990 a
-- 	JOIN fr2016 b
-- 	ON a.country_name = b.country_name
-- 	JOIN pr1990 c 
-- 	ON c.country_name = b.country_name
-- 	JOIN pr2016 d 
-- 	ON d.country_name = b.country_name
-- where b.forest_area_sqkm - a.forest_area_sqkm IS NOT NULL AND d.percentag - c.percentag IS NOT NULL
-- order by diff desc;



-- PART-3 COUNTRY-LEVEL DETAIL


-- Que.2 Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?
-- WITH fa1990 AS (
-- 	SELECT forest_sqkm_percent, country_name, region
-- 	FROM forestation
-- 	WHERE year = 1990 AND forest_sqkm_percent IS NOT NULL  AND country_name !='World'
-- ),
-- 	fa2016 AS (
-- 		SELECT forest_sqkm_percent, country_name, region
-- 	FROM forestation
-- 	WHERE year = 2016 AND forest_sqkm_percent IS NOT NULL  AND country_name !='World'
-- 	)
-- SELECT DISTINCT  ROUND((b.forest_sqkm_percent - a.forest_sqkm_percent )::numeric, 2) AS pr, a.country_name, a.region
-- 	FROM fa2016 a
-- 	JOIN fa1990 b
-- 	ON a.country_name = b.country_name
-- 	ORDER BY pr desc;


-- Que.1  Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?
-- WITH fa1990 AS (
-- 	SELECT SUM(forest_area_sqkm) AS sum_1990, country_name, region
-- 	FROM forestation
-- 	WHERE year = 1990 AND forest_area_sqkm IS NOT NULL AND country_name != 'World'
-- 	GROUP BY country_name, region
-- ),
-- fa2016 AS (
-- 	SELECT SUM(forest_area_sqkm) AS sum_2016, country_name, region
-- 	FROM forestation
-- 	WHERE year = 2016 AND forest_area_sqkm IS NOT NULL AND country_name != 'World'
-- 	GROUP BY country_name, region
-- )
-- SELECT ROUND((sum_1990 - sum_2016) :: numeric, 2) AS di, a.country_name, a.region
-- FROM fa2016 a
-- JOIN fa1990 b 
-- ON a.country_name = b.country_name
-- ORDER BY di DESC;



-- que 3 If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?
-- WITH
-- fa2016 AS (
-- 	SELECT country_name, forest_sqkm_percent, CASE WHEN forest_sqkm_percent >= 75 THEN '75%-100%'  
-- 	                                               WHEN forest_sqkm_percent >= 50 THEN '50%-75%'
-- 	                                               WHEN forest_sqkm_percent >= 25 THEN '25%-50%' 
--                                                    ELSE '0-25%'
-- 	                                               END AS qurtile  
-- 	FROM forestation
-- 	WHERE year = 2016 AND forest_sqkm_percent IS NOT NULL  AND country_name != 'World'
--    )
--     SELECT distinct qurtile, count(*)
--     FROM fa2016
-- 	GROUP BY 1
--    ORDER BY 1;


--que 5 How many countries had a percent forestation higher than the United States in 2016?
    -- WITH t1 AS (
	-- SELECT forest_sqkm_percent, country_name
	-- FROM forestation
	-- WHERE country_name = 'United States' and year = 2016 AND forest_sqkm_percent IS NOT NULL  AND country_name != 'World'
    -- group by 1,2)
    -- SELECT  b.forest_sqkm_percent , a.country_name, count(*), CASE WHEN a.forest_sqkm_percent >= b.forest_sqkm_percent then 'country_name' end AS co
	-- FROM forestation a
	-- JOIN t1 b
	-- ON a.country_name = b.country_name
	-- WHERE a.forest_sqkm_percent >=  b.forest_sqkm_percent AND  year = 2016  AND b.forest_sqkm_percent IS NOT NULL  AND a.country_name != 'World'
    -- GROUP BY 1,2,a.forest_sqkm_percent
	-- ORDER BY 1,2 DESC;
	-- SELECT distinct round(forest_sqkm_percent::numeric, 2), country_name
	-- FROM forestation
	-- WHERE forest_sqkm_percent > 33.39 and year = 2016 AND forest_sqkm_percent IS NOT NULL  AND country_name != 'World'
    -- group by 1,2
	-- Order by 1 desc;


-- Que 4 List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016.
-- WITH
-- fa2016 AS (
-- 	SELECT country_name, forest_sqkm_percent, CASE WHEN forest_sqkm_percent >= 75 THEN '75%-100%'  
-- 	                                               WHEN forest_sqkm_percent >= 50 THEN '50%-75%'
-- 	                                               WHEN forest_sqkm_percent >= 25 THEN '25%-50%' 
--                                                    ELSE '0-25%'
-- 	                                               END AS qurtile  
-- 	FROM forestation
-- 	WHERE year = 2016 AND forest_sqkm_percent IS NOT NULL  AND country_name != 'World'
--    )
--     SELECT distinct a.qurtile, a.country_name, b.region, round(a.forest_sqkm_percent::numeric, 2)
--     FROM fa2016 a
-- 	JOIN forestation b
-- 	ON a.country_name = b.country_name
-- 	WHERE A.qurtile = '75%-100%'
--    ORDER BY 1 desc;

-- PArt >3 Q.1) If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?
-- 	WITH fa1990 AS (
-- 	SELECT SUM(forest_area_sqkm) AS sum_1990, country_name, region
-- 	FROM forestation
-- 	WHERE year = 1990 AND forest_area_sqkm IS NOT NULL AND country_name != 'World'
--     GROUP BY country_name, region
-- ),
	
-- 	fa2016 AS (
-- 	SELECT SUM(forest_area_sqkm) AS sum_2016, country_name, region
-- 	FROM forestation
-- 	WHERE year = 2016 AND forest_area_sqkm IS NOT NULL AND country_name != 'World'
--     GROUP BY country_name, region)
	
--     SELECT  ROUND((sum_1990 - sum_2016)::numeric, 2) AS di  , a.country_name, a.region 
-- 	FROM fa2016 a
-- 	JOIN fa1990 b
-- 	ON a.country_name = b.country_name
--     ORDER BY di DESC;
