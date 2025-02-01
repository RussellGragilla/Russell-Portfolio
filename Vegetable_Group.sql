USE agriculture_vegetable;

DROP TABLE IF EXISTS vege_group;
CREATE TABLE vege_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Vegetable BIGINT DEFAULT 0,
    Tomato BIGINT DEFAULT 0,
    `Sweet Potato` BIGINT DEFAULT 0,
    Pepper BIGINT DEFAULT 0,
    Potato BIGINT DEFAULT 0,
    Cabbage BIGINT DEFAULT 0,
    `Carrot and Turnip` BIGINT DEFAULT 0,
    `Cucumber and Gherkin` BIGINT DEFAULT 0,
    Lettuce BIGINT DEFAULT 0,
    `Cauliflower and Broccoli` BIGINT DEFAULT 0,
    Eggplant BIGINT DEFAULT 0,
    Leek BIGINT DEFAULT 0,
    Spinach BIGINT DEFAULT 0,
    Okra BIGINT DEFAULT 0,
	Asparagus BIGINT DEFAULT 0,
    Artichoke BIGINT DEFAULT 0
);


   
INSERT INTO vege_group
	SELECT 
		veg.Country, 
        veg.`Year`, 
        NULLIF(veg.`Production (t)`, 0) AS Vegetable, 
        NULLIF(tom.`Production (t)`, 0) AS Tomato, 
        NULLIF(swe.`Production (t)`, 0) AS `Sweet Potato`,
        NULLIF(pep.`Production (t)`, 0) AS Pepper, 
        NULLIF(pot.`Production (t)`, 0) AS Potato, 
		NULLIF(cab.`Production (t)`, 0) AS Cabbage, 
        NULLIF(cat.`Production (t)`, 0) AS `Carrot and Turnip`,
        NULLIF(cag.`Production (t)`, 0) AS `Cucumber and Gherkin`,
        NULLIF(let.`Production (t)`, 0) AS Lettuce,
        NULLIF(cb.`Production (t)`, 0) AS `Cauliflower and Broccoli`,
        NULLIF(egg.`Production (t)`, 0) AS Eggplant,
        NULLIF(lek.`Production (t)`, 0) AS Leek,
        NULLIF(spi.`Production (t)`, 0) AS Spinach,
        NULLIF(okr.`Production (t)`, 0) AS Okra,
        NULLIF(asp.`Production (t)`, 0) AS Aspargus,
		NULLIF(art.`Production (t)`, 0) AS Artichoke
	FROM `vegetable-production` veg
	LEFT JOIN `tomato-production` tom
		ON veg.Country = tom.Country
		AND veg.`Year` = tom.`Year`
	LEFT JOIN `sweet-potato-production` swe
		ON tom.Country = swe.Country
		AND tom.`Year` = swe.`Year`
	LEFT JOIN `pepper-production` pep
		ON swe.Country = pep.Country
		AND swe.`Year` = pep.`Year`
	LEFT JOIN `potato-production` pot
		ON pep.Country = pot.Country
		AND pep.`Year` = pot.`Year`
	LEFT JOIN `cabbage-production` cab
		ON pot.Country = cab.Country
		AND pot.`Year` = cab.`Year`
	LEFT JOIN `carrot-and-turnip-production` cat
		ON cab.Country = cat.Country
		AND cab.`Year` = cat.`Year`
	LEFT JOIN `cucumber-and-gherkin-production` cag
		ON cat.Country = cag.Country
		AND cat.`Year` = cag.`Year`
	LEFT JOIN `lettuce-production` let
		ON cag.Country = let.Country
		AND cag.`Year` = let.`Year`
	LEFT JOIN `cauliflower-and-broccoli-production` cb
		ON let.Country = cb.Country
		AND let.`Year` = cb.`Year`
	LEFT JOIN `eggplant-production` egg
		ON cb.Country = egg.Country
		AND cb.`Year` = egg.`Year`
	LEFT JOIN `leek-production` lek
		ON egg.Country = lek.Country
		AND egg.`Year` = lek.`Year`
	LEFT JOIN `spinach-production` spi
		ON lek.Country = spi.Country
		AND lek.`Year` = spi.`Year`
	LEFT JOIN `okra-production` okr
		ON spi.Country = okr.Country
		AND spi.`Year` = okr.`Year`
	LEFT JOIN `asparagus-production` asp
		ON okr.Country = asp.Country
		AND okr.`Year` = asp.`Year`
	LEFT JOIN `artichoke-production` art
		ON asp.Country = art.Country
		AND asp.`Year` = art.`Year`;

        
SELECT * 
FROM vege_group;