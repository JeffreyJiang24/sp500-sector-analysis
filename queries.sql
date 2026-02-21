-- Annual Return by Sector and Year
CREATE TABLE sector_returns AS
SELECT 
    p."GICS Sector" as sector,
    strftime('%Y', s.date) as year,
    ROUND((MAX(s.close) - MIN(s.close)) / MIN(s.close) * 100, 2) as annual_return_pct
FROM all_stocks_5yr s
JOIN SP500 p ON s.Name = p.Symbol
GROUP BY sector, year
ORDER BY year, annual_return_pct DESC;

-- Sector Volatility by Year
CREATE TABLE sector_volatility AS
SELECT 
    p."GICS Sector" as sector,
    strftime('%Y', s.date) as year,
    ROUND(AVG(s.high - s.low), 2) as avg_daily_swing
FROM all_stocks_5yr s
JOIN SP500 p ON s.Name = p.Symbol
GROUP BY sector, year
ORDER BY year, avg_daily_swing DESC;

-- Post-COVID Recovery Analysis
CREATE TABLE covid_recovery AS
SELECT 
    p."GICS Sector" as sector,
    strftime('%Y', s.date) as year,
    ROUND((MAX(s.close) - MIN(s.close)) / MIN(s.close) * 100, 2) as annual_return_pct
FROM all_stocks_5yr s
JOIN SP500 p ON s.Name = p.Symbol
WHERE strftime('%Y', s.date) IN ('2019', '2020', '2021')
GROUP BY sector, year
ORDER BY year, annual_return_pct DESC;
