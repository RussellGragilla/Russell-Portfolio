USE agriculture_vegetables;

SELECT *
FROM vege_group;


SELECT Country, `Year`, Potato, ROUND(Potato/Vegetable * 100, 2) AS `Potato Percent of Total Vegetables`
FROM vege_group
WHERE `Year` = 2021
  AND Country IN ('Africa', 'Asia', 'Europe',
				  'North America', 'South America', 'World');
# Convoluted data for Europe.

SELECT DISTINCT Country
FROM vege_group;
# Getting a list of each country in the dataset, and filtering through ChatGPT to
#pull out only the European countries, to examine this discrepancy further.

SELECT Country, `Year`, Potato, Vegetable,
	CASE
		WHEN Potato / Vegetable > 1 
        THEN 1 ELSE 0 
	END AS `Percent Over 100 Flag`
FROM vege_group
WHERE Country IN ('Austria', 'Belarus', 'Belgium', 'Bosnia and Herzegovina',
					'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark',
                    'Estonia', 'Finland', 'France', 'Germany', 'Hungary', 
                    'Iceland', 'Ireland', 'Italy', 'Latvia', 'Lithuania',
                    'Luxembourg', 'Malta', 'Montenegro', 'Metherlands',
                    'North Macedonia', 'Norway', 'Poland', 'Portugal',
                    'Romania', 'Serbia', 'Slovakia', 'Slovenia', 'Spain',
                    'Sweden', 'Switzerland', 'Ukraine', 'United Kingdom');
# Getting a preliminary look at how many rows are flagged 


DROP TEMPORARY TABLE IF EXISTS temp_vege;
CREATE TEMPORARY TABLE temp_vege (
	Country TEXT,
    `Year` INT,
    Potato BIGINT,
    Vegetable BIGINT,
    `Percent Over 100 Flag` BOOLEAN
);

INSERT INTO temp_vege
	SELECT Country, `Year`, Potato, Vegetable,
    	CASE
		WHEN Potato / Vegetable > 1 
        THEN 1 ELSE 0 
	END AS `Percent Over 100 Flag`
FROM vege_group
WHERE Country IN ('Austria', 'Belarus', 'Belgium', 'Bosnia and Herzegovina',
					'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 'Denmark',
                    'Estonia', 'Finland', 'France', 'Germany', 'Hungary', 
                    'Iceland', 'Ireland', 'Italy', 'Latvia', 'Lithuania',
                    'Luxembourg', 'Malta', 'Montenegro', 'Metherlands',
                    'North Macedonia', 'Norway', 'Poland', 'Portugal',
                    'Romania', 'Serbia', 'Slovakia', 'Slovenia', 'Spain',
                    'Sweden', 'Switzerland', 'Ukraine', 'United Kingdom');
# Creating a temp table that filters out all the non-European countries,
# to simplify my future queries. 


SELECT *
FROM temp_vege;

SELECT Country, 
	SUM(`Percent Over 100 Flag`)/COUNT(*) * 100 AS `Percent Over 100`
FROM temp_vege
GROUP BY Country;

SELECT Country, 
	SUM(`Percent Over 100 Flag`)/COUNT(*) * 100 AS `Percent Over 100`
FROM temp_vege
GROUP BY Country
HAVING SUM(`Percent Over 100 Flag`)/COUNT(*) > 0;

SELECT Country, `Year`, Potato, Vegetable
FROM vege_group
WHERE Country IN ('Cyprus', 'Austria', 'Belgium', 'Estonia', 'France', 'Finland',
				  'Hungary', 'Ireland', 'Lithuania', 'Croatia', 'Romania', 'Poland',
				  'Portugal', 'Slovenia', 'Czechia', 'Denmark', 'Germany', 'Latvia',
				  'Luxembourg', 'Norway', 'Slovakia', 'Sweden', 'Switzerland', 'Ukraine',
				  'United Kingdom', 'Belarus', 'Iceland', 'Serbia', 'Montenegro')
ORDER BY Country, `Year`;
# It appears that whatever information the Vegetable column is conveying, it doesn't include
# potatoes, which draws suspicion to that particular column as useful information,
# as it is vague as to what it is classifying.