USE agriculture_oil_fat;

DROP TABLE IF EXISTS oil_group;
CREATE TABLE oil_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Peanut BIGINT DEFAULT 0,
    Corn BIGINT DEFAULT 0,
    Soybean BIGINT DEFAULT 0,
    Sunflower BIGINT DEFAULT 0,
    Canola BIGINT DEFAULT 0,
    Olive BIGINT DEFAULT 0
);



INSERT INTO oil_group
	SELECT
		g.Country,
		g.`Year`,
		NULLIF(g.`Production (t)`, 0) AS Peanut,
		NULLIF(m.`Production (t)`, 0) AS Corn,
        NULLIF(so.`Production (t)`, 0) AS Soybean,
		NULLIF(su.`Production (t)`, 0) AS Sunflower,
		NULLIF(r.`Production (t)`, 0) AS Canola,
		NULLIF(o.`Production (t)`, 0) AS Olive
	FROM `groundnut-oil-production` g
	LEFT JOIN `maize-oil-production` m
		ON g.Country = m.Country
		AND g.`Year` = m.`Year`
	LEFT JOIN `soybean-oil-production` so
		ON m.Country = so.Country
		AND m.`Year` = so.`Year`
	LEFT JOIN `sunflower-oil-production` su
		ON so.Country = su.Country
		AND so.`Year` = su.`Year`
	LEFT JOIN `rapeseed-production` r
		ON su.Country = r.Country
		AND su.`Year` = r.`Year`
	LEFT JOIN `olive-oil-production` o
		ON r.Country = o.Country
		AND r.`Year` = o.`Year`;
        
SELECT *
FROM oil_group;
