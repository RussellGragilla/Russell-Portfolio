USE agriculture_animal;

DROP TABLE IF EXISTS total_meat_group;
CREATE TABLE total_meat_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	`Beef and Buffalo` BIGINT DEFAULT 0,
    Camel BIGINT DEFAULT 0,
    Chicken BIGINT DEFAULT 0,
    Duck BIGINT DEFAULT 0,
    Goat BIGINT DEFAULT 0,
    Pig BIGINT DEFAULT 0,
    Turkey BIGINT DEFAULT 0,
    Rabbit BIGINT DEFAULT 0,
    `Lamb and Mutton` BIGINT DEFAULT 0,
    Game BIGINT DEFAULT 0,
    Horse BIGINT DEFAULT 0
);

INSERT INTO total_meat_group
	SELECT
		bb.Country,
		bb.`Year`,
		NULLIF(bb.`Production (t)`, 0) AS `Beef and Buffalo`,
		NULLIF(cam.`Production (t)`, 0) AS Camel,
        NULLIF(chi.`Production (t)`, 0) AS Chicken,
		NULLIF(d.`Production (t)`, 0) AS Duck,
		NULLIF(go.`Production (t)`, 0) AS Goat,
		NULLIF(p.`Production (t)`, 0) AS Pig,
		NULLIF(t.`Production (t)`, 0) AS Turkey,
		NULLIF(r.`Production (t)`, 0) AS Rabbit,
		NULLIF(lm.`Production (t)`, 0) AS `Lamb and Mutton`,
		NULLIF(ga.`Production (t)`, 0) AS Game,
		NULLIF(h.`Production (t)`, 0) AS Horse
	FROM `beef-and-buffalo-meat-production` bb
	LEFT JOIN `camel-meat-production` cam
		ON bb.Country = cam.Country
		AND bb.`Year` = cam.`Year`
	LEFT JOIN `chicken-meat-production` chi
		ON cam.Country = chi.Country
		AND cam.`Year` = chi.`Year`
	LEFT JOIN `duck-meat-production` d
		ON chi.Country = d.Country
		AND chi.`Year` = d.`Year`
	LEFT JOIN `goat-meat-production` go
		ON d.Country = go.Country
		AND d.`Year` = go.`Year`
	LEFT JOIN `pig-meat-production` p
		ON go.Country = p.Country
		AND go.`Year` = p.`Year`
	LEFT JOIN `turkey-meat-production` t
		ON p.Country = t.Country
		AND p.`Year` = t.`Year`
	LEFT JOIN `rabbit-meat-production` r
		ON t.Country = r.Country
		AND t.`Year` = r.`Year`
	LEFT JOIN `lamb-and-mutton-meat-production` lm
		ON r.Country = lm.Country
		AND r.`Year` = lm.`Year`
	LEFT JOIN `game-meat-production` ga
		ON lm.Country = ga.Country
		AND lm.`Year` = ga.`Year`
	LEFT JOIN `horse-meat-production` h
		ON ga.Country = h.Country
		AND ga.`Year` = h.`Year`;
        
SELECT *
FROM total_meat_group;
