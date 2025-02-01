USE agriculture_nuts;

DROP TABLE IF EXISTS total_seeds_group;
CREATE TABLE total_seeds_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
    `Sesame Seed` BIGINT DEFAULT 0,
    `Sunflower Seed` BIGINT DEFAULT 0,
    `Mustard Seed` BIGINT DEFAULT 0,
    Linseed BIGINT DEFAULT 0,
    Hempseed BIGINT DEFAULT 0,
    `Poppy Seed` BIGINT DEFAULT 0,
    `Safflower Seed` BIGINT DEFAULT 0
);


INSERT INTO total_seeds_group
	SELECT 
		ses.Country,
		ses.`Year`,
		NULLIF(ses.`Production (t)`, 0) AS `Sesame Seed`,
		NULLIF(sun.`Production (t)`, 0) AS `Sunflower Seed`,
		NULLIF(m.`Production (t)`, 0) AS `Mustard Seed`,
		NULLIF(l.`Production (t)`, 0) AS Linseed,
		NULLIF(h.`Production (t)`, 0) AS Hempseed,
		NULLIF(p.`Production (t)`, 0) AS `Poppy Seed`,
		NULLIF(saf.`Production (t)`, 0) AS `Safflower Seed`
	FROM `sesame-seed-production` ses
	LEFT JOIN `sunflower-seed-production` sun
		ON ses.Country = sun.Country
		AND ses.`Year` = sun.`Year`
	LEFT JOIN `mustard-seed-production` m
		ON sun.Country = m.Country
		AND sun.`Year` = m.`Year`
	LEFT JOIN `linseed-production` l
		ON m.Country = l.Country
		AND m.`Year` = l.`Year`
	LEFT JOIN `hempseed-production` h
		ON l.Country = h.Country
		AND l.`Year` = h.`Year`
	LEFT JOIN `poppy-seed-production` p
		ON h.Country = p.Country
		AND h.`Year` = p.`Year`
	LEFT JOIN `safflower-seed-production` saf
		ON p.Country = saf.Country
		AND p.`Year` = saf.`Year`;
        
SELECT *
FROM total_seeds_group;        
