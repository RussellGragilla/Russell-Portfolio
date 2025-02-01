USE agriculture_animal;

DROP TABLE IF EXISTS eggs_and_dairy_group;
CREATE TABLE eggs_and_dairy_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Egg BIGINT DEFAULT 0,
    `Egg-Hen` BIGINT DEFAULT 0,
    `Egg-Non-Hen` BIGINT DEFAULT 0,
    Milk BIGINT DEFAULT 0,
    Cheese BIGINT DEFAULT 0,
    Whey BIGINT DEFAULT 0
);



INSERT INTO eggs_and_dairy_group
	SELECT
		e.Country,
		e.`Year`,
		NULLIF(e.`Production (t)`, 0) AS Egg,
		NULLIF(eh.`Production (t)`, 0) AS `Egg-Hen`,
        NULLIF(enh.`Production (t)`, 0) AS `Egg-Non-Hen`,
		NULLIF(m.`Production (t)`, 0) AS Milk,
		NULLIF(c.`Production (t)`, 0) AS Cheese,
		NULLIF(w.`Production (t)`, 0) AS Whey
	FROM `egg-production` e
	LEFT JOIN `hen-egg-production` eh
		ON e.Country = eh.Country
		AND e.`Year` = eh.`Year`
	LEFT JOIN `egg-from-other-birds-excl-hens-production` enh
		ON eh.Country = enh.Country
		AND eh.`Year` = enh.`Year`
	LEFT JOIN `milk-production` m
		ON enh.Country = m.Country
		AND enh.`Year` = m.`Year`
	LEFT JOIN `cheese-production` c
		ON m.Country = c.Country
		AND m.`Year` = c.`Year`
	LEFT JOIN `whey-production` w
		ON c.Country = w.Country
		AND c.`Year` = w.`Year`;
        
SELECT *
FROM eggs_and_dairy_group;
