--AFTER CLEANING UP DATA IN SQL, AND BACKING UP TABLES, PROCEEDED TO CLEAN UP THE REMAINING DATA IN EXCEL. NOW RE-EXAMINING DATA
USE PortfolioProject
GO


--Examining industries column, to clean some of the spelling errors or vague descriptions
SELECT industry, COUNT(industry) AS industry_count
FROM fortune3
GROUP BY industry
ORDER BY industry

UPDATE fortune3
SET industry = 'Computer And Data Services'
WHERE industry LIKE '%Computer%'

UPDATE fortune3
SET industry = 'Electronics, Electrical Equipment'
WHERE industry LIKE '%Electronics%'

UPDATE fortune3
SET industry = 'Industrial and Farm Equipment'
WHERE industry LIKE '%Industrial Machinery%'
	OR industry Like '%Equipment Leasing%'

UPDATE fortune3
SET industry = 'Food Consumer Products'
WHERE industry = 'Food'
	OR industry = 'Food Services'
	OR industry = 'Food Production'

UPDATE fortune3
SET industry = 'Metals'
WHERE industry LIKE '%Metal%'

UPDATE fortune3
SET industry = 'Food Consumer Products'
WHERE industry = 'Beverages'

UPDATE fortune3
SET industry = 'Insurance: Life, Health (Stock)'
WHERE industry = 'Insurance: Life, Health (Mutual)'

UPDATE fortune3
SET industry = 'Transportation and Logistics'
WHERE industry = 'Transportation Equipment'

UPDATE fortune3
SET industry = 'Trucking, Truck Leasing'
WHERE industry = 'Trucking'

UPDATE fortune3
SET industry = 'Wholesalers: Food and Grocery'
WHERE industry = 'Wholesaler: Food and Grocery'

UPDATE fortune3
SET industry = 'Wholesalers: Diversified'
WHERE industry = 'Wholesalers'

UPDATE fortune3
SET industry = 'Commercial Banks'
WHERE industry = 'Securities'

UPDATE fortune3
SET industry = 'Utilities: Gas and Electric'
WHERE industry = 'Energy'

UPDATE fortune3
SET industry = 'Food Consumer Products'
WHERE industry = 'Tobacco'

UPDATE fortune3
SET industry = 'Specialty Retailers: Other'
WHERE industry = 'Specialty Retailers'
	OR industry = 'Soaps, Cosmetics'
	OR industry = 'Textiles'

UPDATE fortune3
SET industry = 'Insurance: Property and Casualty (Stock)'
WHERE industry = 'Insurance: Property and Casualty (Mutual)'

UPDATE fortune3 
SET industry = 'Home Equipment, Furnishings'
WHERE industry = 'Furniture'

UPDATE fortune3
SET industry = 'Specialty Retailers: Other'
WHERE industry = 'Rubber and Plastic Products'
	OR industry = 'Toys, Sporting Goods'

UPDATE fortune3
SET industry = 'Commercial Banks'
WHERE industry = 'Savings Institutions'

UPDATE fortune3
SET industry = 'Engineering & Construction'
WHERE industry = 'Marine services'

UPDATE fortune3
SET industry = 'Industrial and Farm Equipment'
WHERE industry = 'Construction and Farm Machinery'

UPDATE fortune3
SET industry = 'Entertainment'
WHERE industry = 'Education'

UPDATE fortune3
SET industry = 'Health Care: Pharmacy and Other Services'
WHERE industry = 'Health Care'



--Examing the sector column, to do the same cleaning as was just done to the industry column
SELECT sector, COUNT(sector)
FROM fortune3
GROUP BY sector
ORDER BY sector

UPDATE fortune3
SET sector = 'Energy'
WHERE name = 'MarketSpan Corporation'

UPDATE fortune3
SET sector = 'Chemicals'
WHERE name = 'Momentive Specialty Chemicals Inc.'

UPDATE fortune3
SET sector = 'Energy'
WHERE name = 'Puget Energy, Inc.'

UPDATE fortune3
SET sector = 'Energy'
WHERE sector = 'Electric'

UPDATE fortune3
SET sector = 'Wholesalers'
WHERE sector = 'Wholesaler'
	OR sector = 'Wholesailers'
	OR sector = 'Wholesailer'

UPDATE fortune3
SET sector = 'Media'
WHERE sector = 'Entertainment'

UPDATE fortune3
SET sector = 'Hotels, Restaurants & Leisure'
WHERE sector = 'Hotels, Casinos, Resorts'
	OR sector = 'Hotels, Restaurants, & Leisure'

UPDATE fortune3
SET sector = 'Retailing'
WHERE sector = 'Retailers'
	OR sector = 'Retaining'

UPDATE fortune3
SET sector = 'Energy'
WHERE sector = 'Pipelines'

UPDATE fortune3
SET sector = 'Hotels, Restaurants & Leisure'
WHERE sector = 'Hotel, Restaurants, & Leisure'

UPDATE fortune3
SET sector = 'Technology'
WHERE sector = 'Telecommunications'

UPDATE fortune3
SET sector = 'Motor Vehicles & Parts'
WHERE sector = 'Automotive'

UPDATE fortune3
SET sector = 'Materials'
WHERE sector = 'Solid Waste'
	OR sector = 'Products'
	OR sector = 'Express Freight and Air Cargo'
	OR sector = 'Equipment'
	OR sector = 'Electronics'
	OR sector = 'Cosmetics'

UPDATE fortune3
SET sector = 'Health Care'
WHERE sector = 'Pharmaceuticals'

UPDATE fortune3
SET sector = 'Materials'
WHERE sector = 'Furnishings'

UPDATE fortune3
SET sector = 'Engineering & Construction'
WHERE sector = 'Homebuilders'

UPDATE fortune3
SET sector = 'Retailing'
WHERE sector = 'Services'

UPDATE fortune3
SET sector = 'Retailing'
WHERE sector = 'Apparel'




--Query that shows revenue growth year over year
WITH revenue_growth AS (
	SELECT *,
		LAG(revenue_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_revenue
	FROM fortune3
)
SELECT *,
		ROUND((revenue_mil - previous_year_revenue) / previous_year_revenue * 100, 2) AS revenue_growth_percent
FROM revenue_growth


--Query that shows percentage each industry makes up
WITH total_industry AS (
    SELECT COUNT(*) AS total_i FROM fortune3
)
SELECT industry, 
		COUNT(*) AS industry_count,
		ROUND((COUNT(*) * 100.0 / (SELECT total_i FROM total_industry)), 2) AS industry_percentage
FROM fortune3
GROUP BY industry
ORDER BY industry_percentage DESC;


--Query that shows percentage each sector makes up
WITH total_sector AS (
	SELECT COUNT(*) AS total_s FROM fortune3
)
SELECT sector,
		COUNT(*) AS sector_count,
		ROUND((COUNT(*) * 100.0 / (SELECT total_s FROM total_sector)), 2) AS sector_percentage
FROM fortune3
GROUP BY sector
ORDER BY sector_percentage DESC




--Query that shows percentage each state has a company headquarters
WITH total_headquarters_state AS (
	SELECT COUNT(*) AS total_hq_state FROM fortune3
)
SELECT headquarters_state,
		COUNT(*) AS headquarters_state_count,
		ROUND((COUNT(*) * 100.0 / (SELECT total_hq_state FROM total_headquarters_state)), 2) AS headquarters_state_percentage
FROM fortune3
GROUP BY headquarters_state
ORDER BY headquarters_state_percentage DESC




--Combining CTEs into one large query
WITH revenue_growth AS (
	SELECT *,
		LAG(revenue_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_revenue
	FROM fortune3
),
	total_industry AS (
    SELECT COUNT(*) AS total_i FROM fortune3
),
	total_sector AS (
	SELECT COUNT(*) AS total_s FROM fortune3
),
	total_headquarters_state AS (
	SELECT COUNT(*) AS total_hq_state FROM fortune3
)
SELECT f.name, f.rank, f.year, f.industry, 
		ROUND((COUNT(*) * 100.0 / (SELECT total_i FROM total_industry)), 2) AS industry_percentage,
		f.sector, 
		ROUND((COUNT(*) * 100.0 / (SELECT total_s FROM total_sector)), 2) AS sector_percentage,
		f.headquarters_state, 
		ROUND((COUNT(*) * 100.0 / (SELECT total_hq_state FROM total_headquarters_state)), 2) AS headquarters_state_percentage,
		f.headquarters_city, f.market_value_mil, f.revenue_mil, previous_year_revenue,
		ROUND((f.revenue_mil - previous_year_revenue) / previous_year_revenue * 100, 2) AS revenue_growth_percent,
		f.profit_mil, f.asset_mil, f.employees
FROM fortune3 f, 
	revenue_growth, 
	total_industry, 
	total_sector, 
	total_headquarters_state
GROUP BY f.name, f.rank, f.year, f.industry, f.sector, f.headquarters_state, f.headquarters_city, 
		f.market_value_mil, f.revenue_mil, previous_year_revenue, f.profit_mil, f.asset_mil, f.employees




--Query is talking extremely long (over an hour). Getting advice to try to clean it up, and make it run much faster.

--This query is more complicated, but resolves the query dramatically faster.
WITH revenue_growth AS (
		SELECT *,
			LAG(revenue_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_revenue
		FROM fortune3
),
	market_value_growth AS (
		SELECT *,
			LAG(market_value_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_market_value
		FROM fortune3
),
	profit_growth AS (
		SELECT *,
			LAG(profit_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_profit
		FROM fortune3
),
	asset_growth AS (
		SELECT *,
			LAG(asset_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_assets
		FROM fortune3
),
	total_industry AS (
		SELECT COUNT(*) AS total_i FROM fortune3
),
	industry_percentage AS (
		SELECT industry, 
			COUNT(*) AS industry_count,
			ROUND((COUNT(*) * 100.0 / (SELECT total_i FROM total_industry)), 2) AS industry_percentage
		FROM fortune3
		GROUP BY industry
),
	total_sector AS (
		SELECT COUNT(*) AS total_s FROM fortune3
),
	sector_percentage AS (
		SELECT sector,
			COUNT(*) AS sector_count,
			ROUND((COUNT(*) * 100.0 / (SELECT total_s FROM total_sector)), 2) AS sector_percentage
		FROM fortune3
		GROUP BY sector
),
	total_headquarters_state AS (
		SELECT COUNT(*) AS total_hq_state FROM fortune3
),
	headquarters_state_percentage AS (
		SELECT headquarters_state,
			COUNT(*) AS headquarters_state_count,
			ROUND((COUNT(*) * 100.0 / (SELECT total_hq_state FROM total_headquarters_state)), 2) AS headquarters_state_percentage
		FROM fortune3
		GROUP BY headquarters_state
)
SELECT 
    f.name, 
    f.rank, 
    f.year, 
    f.industry, 
    ip.industry_percentage,
    f.sector, 
    sp.sector_percentage,
    f.headquarters_state, 
    hsp.headquarters_state_percentage,
    f.headquarters_city, 
    f.market_value_mil,
    mg.previous_year_market_value,
    CASE 
        WHEN mg.previous_year_market_value = 0 THEN NULL
        ELSE ROUND((f.market_value_mil - mg.previous_year_market_value) / mg.previous_year_market_value * 100, 2)
    END AS market_value_growth_percent,
    f.revenue_mil, 
    rg.previous_year_revenue,
    CASE 
        WHEN rg.previous_year_revenue = 0 THEN NULL
        ELSE ROUND((f.revenue_mil - rg.previous_year_revenue) / rg.previous_year_revenue * 100, 2)
    END AS revenue_growth_percent,
    f.profit_mil,
    pg.previous_year_profit,
    CASE 
        WHEN pg.previous_year_profit = 0 THEN NULL
        ELSE ROUND((f.profit_mil - pg.previous_year_profit) / pg.previous_year_profit * 100, 2)
    END AS profit_growth_percent,
    f.asset_mil,
    ag.previous_year_assets,
    CASE 
        WHEN ag.previous_year_assets = 0 THEN NULL
        ELSE ROUND((f.asset_mil - ag.previous_year_assets) / ag.previous_year_assets * 100, 2)
    END AS asset_growth_percent,
    f.employees
FROM 
    fortune3 f
JOIN revenue_growth rg 
	ON rg.name = f.name 
	AND rg.year = f.year
LEFT JOIN market_value_growth mg 
	ON mg.name = f.name 
	AND mg.year = f.year
LEFT JOIN profit_growth pg 
	ON pg.name = f.name 
	AND pg.year = f.year
LEFT JOIN asset_growth ag 
	ON ag.name = f.name 
	AND ag.year = f.year
LEFT JOIN industry_percentage ip 
	ON f.industry = ip.industry
LEFT JOIN sector_percentage sp 
	ON f.sector = sp.sector
LEFT JOIN headquarters_state_percentage hsp 
	ON f.headquarters_state = hsp.headquarters_state
ORDER BY f.name, f.year



























































































































































































