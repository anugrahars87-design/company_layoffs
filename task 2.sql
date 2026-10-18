 CREATE TABLE company_layoffs (
    event_id VARCHAR(10) PRIMARY KEY,
    company VARCHAR(255),
    hq_city VARCHAR(255),
    country VARCHAR(255),
    industry VARCHAR(100),
    funding_stage VARCHAR(100),
    funding_usd_millions DECIMAL(15,2),
    funding_band VARCHAR(50),
    laid_off_count INT,
    layoff_size_band VARCHAR(50),
    layoff_date DATE,
    year INT,
    quarter VARCHAR(5),
    month INT,
    month_name VARCHAR(20),
    week_of_year INT,
    is_mass_layoff BOOLEAN,
    is_mega_layoff BOOLEAN,
    ai_related BOOLEAN,
    source_url TEXT,
    source_attribution VARCHAR(255)
);

select * from company_layoffs
-- total number of employees laid off?
select sum(laid_off_count) from company_layoffs
--How many companies
select distinct company from company_layoffs
--How many countries and industries are represented
select  count(country),count(industry) from company_layoffs
--average percentage of workforce laid off?

--What is the largest single layoff event? 
select * from company_layoffs where laid_off_count= (select  max(laid_off_count) from company_layoffs)
 --
 ---
 --2
select year, sum(laid_off_count)
from company_layoffs 
group by year
order by count(laid_off_count) desc


select month_name,year, sum(laid_off_count)
from company_layoffs 
group by year, month_name
order by sum(laid_off_count) desc


select month_name, sum(laid_off_count)
from company_layoffs 
group by month_name
order by sum(laid_off_count) desc

select year,count(event_id) from company_layoffs
group by year
order by year 
--3--
--33
---

select company, max(laid_off_count)
from company_layoffs 
group by company
order by count(laid_off_count) desc
limit 10
--Which companies had the highest percentage of workforce laid off?
--
select company,count(event_id)
from company_layoffs 
group by company
order by count(company) desc

select company,sum(laid_off_count)
from company_layoffs 
group by company
order by count(company) desc
--44
--
--
select industry
from company_layoffs where laid_off_count = (select  max(laid_off_count)
from company_layoffs) 

select industry, max(laid_off_count)
from company_layoffs 
group by industry
order by count(laid_off_count) desc
limit 10
--Which industries had the highest average layoff percentage
SELECT 
industry,SUM(laid_off_count) AS total_laid_off,(SUM(laid_off_count) * 100.0 / (SELECT SUM(laid_off_count) FROM company_layoffs))AS percentage_of_total
FROM company_layoffs
GROUP BY industry
ORDER BY percentage_of_total DESC;


select year,industry,count(*)
from  company_layoffs
group by year ,industry
order by year
---55
--
select country
from company_layoffs where laid_off_count = (select  max(laid_off_count)
from company_layoffs) 

select country, max(laid_off_count)
from company_layoffs 
group by country
order by count(laid_off_count) desc
limit 10
--. What percentage of global layoffs came from the top 5 countries? 
--
--Which countries had the highest average layoff percentage? 
--
--Can you create a map showing layoffs by country/location?
--
--66
select funding_stage
from company_layoffs where laid_off_count = (select  max(laid_off_count)
from company_layoffs) 

select funding_stage , sum(laid_off_count)
from company_layoffs 
group by funding_stage
order by count(laid_off_count) desc

select funding_stage , avg(laid_off_count)
from company_layoffs 
group by funding_stage
order by count(laid_off_count) desc
--Does the number of layoffs appear to differ significantly between company stages?
--
--777
--77
-- Relationship between funds raised and layoffs
SELECT 
    funding_stage,
    ROUND(AVG(funding_usd_millions), 2) AS avg_funds_raised_millions,
    SUM(laid_off_count) AS total_laid_off,
    ROUND(AVG(laid_off_count), 2) AS avg_laid_off_per_event
FROM company_layoffs
WHERE funding_usd_millions IS NOT NULL
GROUP BY funding_stage
ORDER BY avg_funds_raised_millions DESC;


-- Do highly funded companies also have high layoffs?
SELECT 
    company,
    funding_stage,
    funding_usd_millions,
    laid_off_count
FROM company_layoffs
WHERE funding_usd_millions IS NOT NULL
ORDER BY funding_usd_millions DESC, laid_off_count DESC;

-- Companies with high funding but large layoffs
SELECT 
    company,
    funding_stage,
    funding_usd_millions,
    laid_off_count,
    layoff_date
FROM company_layoffs
WHERE funding_usd_millions IS NOT NULL
  AND funding_usd_millions >= 100   -- threshold for "significant funding" (adjust as needed)
  AND laid_off_count >= 500         -- threshold for "large layoffs" (adjust as needed)
ORDER BY funding_usd_millions DESC, laid_off_count DESC;

