USE agriculture_sweeteners;

DROP TABLE IF EXISTS sweets_group;
CREATE TABLE sweets_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Molasses BIGINT DEFAULT 0,
    Honey BIGINT DEFAULT 0,
    `Sugar Cane` BIGINT DEFAULT 0,
    `Sugar Beet` BIGINT DEFAULT 0
);



INSERT INTO sweets_group
	SELECT
		m.Country,
		m.`Year`,
		NULLIF(m.`Production (t)`, 0) AS Molasses,
		NULLIF(h.`Production (t)`, 0) AS Honey,
        NULLIF(sc.`Production (t)`, 0) AS `Sugar Cane`,
		NULLIF(sb.`Production (t)`, 0) AS `Sugar Beet`
	FROM `molasses-production` m
	LEFT JOIN `honey-production` h
		ON m.Country = h.Country
		AND m.`Year` = h.`Year`
	LEFT JOIN `sugar-cane-production` sc
		ON h.Country = sc.Country
		AND h.`Year` = sc.`Year`
	LEFT JOIN `sugar-beet-production` sb
		ON sc.Country = sb.Country
		AND sc.`Year` = sb.`Year`;
        
SELECT *
FROM sweets_group;