USE agriculture_fruit;

DROP TABLE IF EXISTS total_fruit_group;
CREATE TABLE total_fruit_group (
	Country TEXT,
    `Year` INT DEFAULT 0,
	Orange BIGINT DEFAULT 0,
    Grapefruit BIGINT DEFAULT 0,
    Tangerine BIGINT DEFAULT 0,
    Strawberry BIGINT DEFAULT 0,
    Blueberry BIGINT DEFAULT 0,
    Raspberry BIGINT DEFAULT 0,
    Cranberry BIGINT DEFAULT 0,
    Currant BIGINT DEFAULT 0,
    Banana BIGINT DEFAULT 0,
    Mango BIGINT DEFAULT 0,
    Papaya BIGINT DEFAULT 0,
    Kiwi BIGINT DEFAULT 0,
    Avocado BIGINT DEFAULT 0,
    Cherry BIGINT DEFAULT 0,
    Apricot BIGINT DEFAULT 0,
	`Peach and Nectarine` BIGINT DEFAULT 0,
    Plum BIGINT DEFAULT 0,
    Watermelon BIGINT DEFAULT 0,
    Melon BIGINT DEFAULT 0,
    Pear BIGINT DEFAULT 0,
    Apple BIGINT DEFAULT 0,
    Grape BIGINT DEFAULT 0
);


INSERT INTO total_fruit_group
	SELECT 
		t.Country, t.`Year`, Orange, Grapefruit,Tangerine, Strawberry,
        Blueberry, Raspberry, Cranberry, Currant, Banana, Mango, Papaya,
        Kiwi, Avocado, Cherry, Apricot, `Peach and Nectarine`, Plum,
        Watermelon, Melon, Pear, Apple, Grape
	FROM tropical_fruit_group t
	LEFT JOIN citrus_fruit_group c
		ON t.Country = c.Country
		AND t.`Year` = c.`Year`
	LEFT JOIN other_fruit_group o
		ON c.Country = o.Country
		AND c.`year` = o.`year`
	LEFT JOIN melon_group m
		ON o.Country = m.Country
		AND o.`year` = m.`year`
	LEFT JOIN stone_fruit_group s
		ON m.Country = s.Country
		AND m.`year` = s.`year`
	LEFT JOIN berry_group b
		ON s.Country = b.Country
		AND s.`year` = b.`year`;
        
SELECT * 
FROM total_fruit_group;
