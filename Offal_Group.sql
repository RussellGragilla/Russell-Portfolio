USE agriculture_animal;

DROP TABLE IF EXISTS total_offal_group;
CREATE TABLE total_offal_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Pig BIGINT DEFAULT 0,
    Sheep BIGINT DEFAULT 0,
    Goat BIGINT DEFAULT 0,
    Horse BIGINT DEFAULT 0,
    Camel BIGINT DEFAULT 0,
    Buffalo BIGINT DEFAULT 0
);


INSERT INTO total_offal_group
	SELECT
		p.Country,
		p.`Year`,
		NULLIF(p.`Production (t)`, 0) AS Pig,
		NULLIF(s.`Production (t)`, 0) AS Sheep,
        NULLIF(g.`Production (t)`, 0) AS Goat,
		NULLIF(h.`Production (t)`, 0) AS Horse,
		NULLIF(c.`Production (t)`, 0) AS Camel,
		NULLIF(b.`Production (t)`, 0) AS Buffalo
	FROM `pig-offal-production` p
	LEFT JOIN `sheep-offal-production` s
		ON p.Country = s.Country
		AND p.`Year` = s.`Year`
	LEFT JOIN `goat-offal-production` g
		ON s.Country = g.Country
		AND s.`Year` = g.`Year`
	LEFT JOIN `horse-offal-production` h
		ON g.Country = h.Country
		AND g.`Year` = h.`Year`
	LEFT JOIN `camel-offal-production` c
		ON h.Country = c.Country
		AND h.`Year` = c.`Year`
	LEFT JOIN `buffalo-offal-production` b
		ON c.Country = b.Country
		AND c.`Year` = b.`Year`;


SELECT *
FROM total_offal_group;

