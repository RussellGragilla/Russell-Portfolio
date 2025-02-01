USE agriculture_fruit;

SELECT *
FROM total_fruit_group;

SELECT DISTINCT(Country)
FROM total_fruit_group
ORDER BY Country;

SELECT *
FROM total_fruit_group
WHERE Country IN ('Africa', 'Asia', 'Europe', 
				  'North America', 'South America', 'World')
ORDER BY Country, `Year`;

SELECT 
	Country, 
    MAX(Orange), MAX(Grapefruit), MAX(Tangerine), MAX(Strawberry),
    MAX(Blueberry), MAX(Raspberry), MAX(COALESCE(Cranberry, 0)), MAX(COALESCE(Currant, 0)),
    MAX(Banana), MAX(COALESCE(Mango, 0)), MAX(COALESCE(Papaya, 0)), MAX(COALESCE(Kiwi, 0)), MAX(COALESCE(Avocado, 0)),
    MAX(Cherry), MAX(Apricot), MAX(`Peach and Nectarine`), MAX(Plum),
    MAX(Watermelon), MAX(Melon), MAX(Pear), MAX(Apple), MAX(Grape)
FROM total_fruit_group
WHERE Country IN ('Africa', 'Asia', 'Europe', 
				  'North America', 'South America', 'World')
GROUP BY Country
ORDER BY Country;

WITH rolling_total_table AS (
SELECT Country, `Year`, Orange,
ROUND(SUM(Orange) OVER (PARTITION BY COUNTRY ORDER BY `Year`) / 1000000, 2) AS rolling_total_millions
FROM total_fruit_group
WHERE Country IN ('Africa', 'Asia', 'Europe', 
				  'North America', 'South America', 'World')
),
	yearly_growth_table AS (
SELECT Country, `Year`, ROUND(Orange / 1000000, 2) AS oranges_millions, rolling_total_millions, 
	LEAD(rolling_total_millions) OVER (ORDER BY Country, `Year`) - rolling_total_millions AS yearly_growth_millions
FROM rolling_total_table
)
SELECT 
	afr.Country, 
	afr.`Year`, 
    afr.oranges_millions, 
    afr.rolling_total_millions, 
    afr.yearly_growth_millions,
	asi.Country,
    asi.oranges_millions, 
    asi.rolling_total_millions, 
    asi.yearly_growth_millions,
	eur.Country,
    eur.oranges_millions, 
    eur.rolling_total_millions, 
    eur.yearly_growth_millions,
	nam.Country,
    nam.oranges_millions, 
    nam.rolling_total_millions, 
    nam.yearly_growth_millions,
	sam.Country,
    sam.oranges_millions, 
    sam.rolling_total_millions, 
    sam.yearly_growth_millions,
	wld.Country,
    wld.oranges_millions, 
    wld.rolling_total_millions, 
    wld.yearly_growth_millions
FROM yearly_growth_table afr
JOIN yearly_growth_table asi
	ON afr.`Year` = asi.`Year`
    AND asi.Country = 'Asia'
JOIN yearly_growth_table eur
	ON asi.`Year` = eur.`Year`
    AND eur.Country = 'Europe'
JOIN yearly_growth_table nam
	ON eur.`Year` = nam.`Year`
    AND nam.Country = 'North America'
JOIN yearly_growth_table sam
	ON nam.`Year` = sam.`Year`
    AND sam.Country = 'South America'
JOIN yearly_growth_table wld
	ON sam.`Year` = wld.`Year`
    AND wld.Country = 'World'
WHERE afr.Country = 'Africa'
ORDER BY afr.`Year`;
