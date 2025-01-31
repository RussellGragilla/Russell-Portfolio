--AGGREGATING FORTUNE DATA IN VARIOUS WAYS

USE PortfolioProject
GO

SELECT *
FROM fortune2

--Total market cap per year
SELECT year, 
	SUM(market_value_mil) AS market_cap_per_year
FROM fortune
WHERE year >= 2013
GROUP BY year
ORDER BY year

--Times a company was in the top 10
SELECT name, COUNT(name) AS times_in_top_10
FROM fortune
WHERE rank BETWEEN 1 AND 10
GROUP BY name

--Average amount of people employed by Fortune 500 year 2015 on
SELECT year, AVG(employees) AS avg_employees_per_year
FROM fortune2
GROUP BY year
HAVING year >= 2015
ORDER BY year

--Counts of how frequently each industry is represented through the years
SELECT industry, COUNT(industry) AS industry_count
FROM fortune2
GROUP BY industry
ORDER BY industry

--Counts of how frequently cities where company headquarters are represented through the years
SELECT headquarters_city, COUNT(headquarters_city)
FROM fortune2
GROUP BY headquarters_city
ORDER BY headquarters_city

--Counts of how frequently states where company headquarters are represented through the years
SELECT headquarters_state, COUNT(headquarters_state)
FROM fortune2
GROUP BY headquarters_state
ORDER BY headquarters_state

--Average profit per company per year
SELECT name, year, AVG(profit_mil) AS avg_profit
FROM fortune2
WHERE year >= 2013
GROUP BY name, year
ORDER BY name

--Average profit per industry per year
SELECT industry, year, AVG(profit_mil) AS avg_profit
FROM fortune2
WHERE year >= 2013
GROUP BY industry, year
ORDER BY industry, year

--Total revenue and average profit per industry
SELECT industry, 
	SUM(revenue_mil) AS total_revenue, 
	AVG(profit_mil) AS avg_profit
FROM fortune2
GROUP BY industry

--TEST WINDOW FUNCTIONS
SELECT name, revenue_mil,
	RANK() OVER (PARTITION BY industry ORDER BY revenue_mil DESC) AS revenue_rank
FROM fortune2

--TEST WINDOW FUNCTIONS
SELECT name, revenue_mil,
	SUM(revenue_mil) OVER (ORDER BY year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_revenue
FROM fortune2


--Query to show the year by year profit growth or loss for each company                                           
WITH revenue_growth AS (
	SELECT name, year, revenue_mil,
		LAG(revenue_mil) OVER (PARTITION BY name ORDER BY year) AS previous_year_revenue
	FROM fortune2
)
SELECT name, year, revenue_mil,
		(revenue_mil - previous_year_revenue) / previous_year_revenue * 100 AS revenue_growth_percent
FROM revenue_growth
WHERE previous_year_revenue IS NOT NULL

