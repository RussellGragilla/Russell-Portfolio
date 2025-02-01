USE agriculture_cereal;

DROP TABLE IF EXISTS total_cereal_group;
CREATE TABLE total_cereal_group (
	County TEXT,
    `Year` INT DEFAULT 0,
    Wheat BIGINT DEFAULT 0,
    Rice BIGINT DEFAULT 0,
    Corn BIGINT DEFAULT 0,
    Oat BIGINT DEFAULT 0,
    Barley BIGINT DEFAULT 0,
    Rye BIGINT DEFAULT 0,
    Sorghum BIGINT DEFAULT 0,
    Buckwheat BIGINT DEFAULT 0,
    Quinoa BIGINT DEFAULT 0
);

INSERT INTO total_cereal_group
	SELECT 
		s.Country, 
		s.`Year`, 
		NULLIF(w.`Production (t)`, 0) AS Wheat, 
		NULLIF(ri.`Production (t)`, 0) AS Rice,
		NULLIF(m.`Production (t)`, 0) AS Corn,
		NULLIF(o.`Production (t)`, 0) AS Oat,
		NULLIF(ba.`Production (t)`, 0) AS Barley,
		NULLIF(ry.`Production (t)`, 0) AS Rye,
		NULLIF(s.`Production (t)`, 0) AS Sorghum,
		NULLIF(bu.`Production (t)`, 0) AS Buckwheat,
		NULLIF(q.`Production (t)`, 0) AS Quinoa
	FROM `sorghum-production` s
	LEFT JOIN `oat-production` o
		ON s.Country = o.Country
		AND s.`Year` = o.`Year`
	LEFT JOIN `maize-production` m
		ON o.Country = m.Country
		AND o.`Year` = m.`Year`
	LEFT JOIN `rye-production` ry
		ON m.Country = ry.Country
		AND m.`Year` = ry.`Year`
	LEFT JOIN `rice-production` ri
		ON ry.Country = ri.Country
		AND ry.`Year` = ri.`Year`
	LEFT JOIN `wheat-production` w
		ON ri.Country = w.Country
		AND ri.`Year` = w.`Year`
	LEFT JOIN `barley-production` ba
		ON w.Country = ba.Country
		AND w.`Year` = ba.`Year`
	LEFT JOIN `buckwheat-production` bu
		ON ba.Country = bu.Country
		AND ba.`Year` = bu.`Year`
	LEFT JOIN `quinoa-production` q
		ON bu.Country = q.Country
		AND bu.`Year` = q.`Year`;
        
SELECT *
FROM total_cereal_group;
