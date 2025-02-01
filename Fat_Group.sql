USE agriculture_oil_fat;

DROP TABLE IF EXISTS fat_group;
CREATE TABLE fat_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Sheep BIGINT DEFAULT 0,
    Cattle BIGINT DEFAULT 0,
    Pig BIGINT DEFAULT 0,
    Goat BIGINT DEFAULT 0,
    Camel BIGINT DEFAULT 0,
    Buffalo BIGINT DEFAULT 0
);



INSERT INTO fat_group
	SELECT
		s.Country,
		s.`Year`,
		NULLIF(s.`Production (t)`, 0) AS Sheep,
		NULLIF(cat.`Production (t)`, 0) AS Cattle,
        NULLIF(p.`Production (t)`, 0) AS Pig,
		NULLIF(g.`Production (t)`, 0) AS Goat,
		NULLIF(cam.`Production (t)`, 0) AS Camel,
		NULLIF(b.`Production (t)`, 0) AS Buffalo
	FROM `sheep-fat-production` s
	LEFT JOIN `cattle-fat-production` cat
		ON s.Country = cat.Country
		AND s.`Year` = cat.`Year`
	LEFT JOIN `pig-fat-production` p
		ON cat.Country = p.Country
		AND cat.`Year` = p.`Year`
	LEFT JOIN `goat-fat-production` g
		ON p.Country = g.Country
		AND p.`Year` = g.`Year`
	LEFT JOIN `camel-fat-production` cam
		ON g.Country = cam.Country
		AND g.`Year` = cam.`Year`
	LEFT JOIN `buffalo-fat-production` b
		ON cam.Country = b.Country
		AND cam.`Year` = b.`Year`;
        
SELECT *
FROM fat_group;