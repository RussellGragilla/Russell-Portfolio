USE agriculture_nuts;

DROP TABLE IF EXISTS total_nuts_group;
CREATE TABLE total_nuts_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
    Walnut BIGINT DEFAULT 0,
    Almond BIGINT DEFAULT 0,
    `Brazil Nut` BIGINT DEFAULT 0,
    Cashew BIGINT DEFAULT 0,
    Hazelnut BIGINT DEFAULT 0,
    Chestnut BIGINT DEFAULT 0,
    Pistachio BIGINT DEFAULT 0
);

INSERT INTO total_nuts_group
	SELECT 
		w.Country,
		w.`Year`,
		NULLIF(w.`Production (t)`, 0) AS Walnut,
		NULLIF(a.`Production (t)`, 0) AS Almond,
		NULLIF(b.`Production (t)`, 0) AS `Brazil Nut`,
		NULLIF(c.`Production (t)`, 0) AS Cashew,
		NULLIF(h.`Production (t)`, 0) AS Hazelnut,
		NULLIF(ch.`Production (t)`, 0) AS Chestnut,
		NULLIF(p.`Production (t)`, 0) AS Pistachio
	FROM `walnut-production` w
	LEFT JOIN `almond-production` a
		ON w.Country = a.Country
		AND w.`Year` = a.`Year`
	LEFT JOIN `brazil-nut-production` b
		ON a.Country = b.Country
		AND a.`Year` = b.`Year`
	LEFT JOIN `cashew-production` c
		ON b.Country = c.Country
		AND b.`Year` = c.`Year`
	LEFT JOIN `hazelnut-production` h
		ON c.Country = h.Country
		AND c.`Year` = h.`Year`
	LEFT JOIN `chestnut-production` ch
		ON h.Country = ch.Country
		AND h.`Year` = ch.`Year`
	LEFT JOIN `pistachio-production` p
		ON ch.Country = p.Country
		AND ch.`Year` = p.`Year`;

SELECT *
FROM total_nuts_group;