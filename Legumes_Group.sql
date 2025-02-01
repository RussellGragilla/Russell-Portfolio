USE agriculture_legumes;

DROP TABLE IF EXISTS legumes_group;
CREATE TABLE legumes_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
    `Broad Bean` BIGINT DEFAULT 0,
    Chickpea BIGINT DEFAULT 0,
    `Cow Pea` BIGINT DEFAULT 0,
    `Dry Bean` BIGINT DEFAULT 0,
    `Dry Pea` BIGINT DEFAULT 0,
    `Green Bean` BIGINT DEFAULT 0,
    `Green Pea` BIGINT DEFAULT 0,
    Lentil BIGINT DEFAULT 0,
    `Pigeon Pea` BIGINT DEFAULT 0
);

INSERT INTO legumes_group
	SELECT
		db.Country,
		db.`Year`,
		NULLIF(db.`Production (t)`, 0) AS `Dry Bean`,
		NULLIF(dp.`Production (t)`, 0) AS `Dry Pea`,
		NULLIF(bb.`Production (t)`, 0) AS `Broad Bean`,
		NULLIF(ch.`Production (t)`, 0) AS Chickpea,
		NULLIF(cp.`Production (t)`, 0) AS `Cow Pea`,
		NULLIF(gb.`Production (t)`, 0) AS `Green Bean`,
		NULLIF(gp.`Production (t)`, 0) AS `Green Pea`,
		NULLIF(l.`Production (t)`, 0) AS Lentil,
		NULLIF(pp.`Production (t)`, 0) AS `Pigeon Pea`
	FROM `dry-bean-production` db
	LEFT JOIN `dry-pea-production` dp
		ON db.Country = dp.Country
		AND db.`Year` = dp.`Year`
	LEFT JOIN `broad-bean-production` bb
		ON dp.Country = bb.Country
		AND dp.`Year` = bb.`Year`
	LEFT JOIN `chickpea-production` ch
		ON bb.Country = ch.Country
		AND bb.`Year` = ch.`Year`
	LEFT JOIN `cow-pea-production` cp
		ON ch.Country = cp.Country
		AND ch.`Year` = cp.`Year`
	LEFT JOIN `green-bean-production` gb
		ON cp.Country = gb.Country
		AND cp.`Year` = gb.`Year`
	LEFT JOIN `green-pea-production` gp
		ON gb.Country = gp.Country
		AND gb.`Year` = gp.`Year`
	LEFT JOIN `lentil-production` l
		ON gp.Country = l.Country
		AND gp.`Year` = l.`Year`
	LEFT JOIN `pigeon-pea-production` pp
		ON l.Country = pp.Country
		AND l.`Year` = pp.`Year`;
        
SELECT *
FROM legumes_group;