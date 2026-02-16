SELECT * FROM layoffs LIMIT 10;

SELECT COUNT(*) FROM layoffs;

SELECT MIN(date) as earliest, MAX(date) as latest FROM layoffs;

SELECT 
    SUM(total_laid_off) as total_layoffs,
    COUNT(DISTINCT company) as num_companies,
    ROUND(AVG(total_laid_off), 0) as avg_per_company
FROM layoffs;

SELECT 
    year,
    SUM(total_laid_off) as total_layoffs,
    COUNT(DISTINCT company) as companies_affected
FROM layoffs
GROUP BY year
ORDER BY year;

SELECT 
    year,
    quarter,
    SUM(total_laid_off) as total_layoffs
FROM layoffs
GROUP BY year, quarter
ORDER BY year, quarter;

SELECT 
    industry,
    SUM(total_laid_off) as total_layoffs,
    COUNT(*) as num_events,
    ROUND(AVG(percentage_laid_off), 1) as avg_percentage
FROM layoffs
GROUP BY industry
ORDER BY total_layoffs DESC;

SELECT 
    industry,
    year,
    SUM(total_laid_off) as total_layoffs
FROM layoffs
GROUP BY industry, year
ORDER BY industry, year;

SELECT 
    company,
    location,
    industry,
    SUM(total_laid_off) as total_layoffs
FROM layoffs
GROUP BY company, location, industry
ORDER BY total_layoffs DESC
LIMIT 10;

SELECT 
    company,
    COUNT(*) as num_rounds,
    SUM(total_laid_off) as total_layoffs,
    MIN(date) as first_layoff,
    MAX(date) as last_layoff
FROM layoffs
GROUP BY company
HAVING num_rounds > 1
ORDER BY total_layoffs DESC;

SELECT 
    company,
    location,
    total_laid_off,
    ROUND(percentage_laid_off, 1) as pct_laid_off,
    stage,
    date
FROM layoffs
WHERE percentage_laid_off >= 50
ORDER BY percentage_laid_off DESC;

SELECT 
    location,
    SUM(total_laid_off) as total_layoffs,
    COUNT(DISTINCT company) as num_companies
FROM layoffs
GROUP BY location
ORDER BY total_layoffs DESC;

SELECT 
    company,
    industry,
    total_laid_off,
    percentage_laid_off
FROM layoffs
WHERE location = 'San Francisco'
ORDER BY total_laid_off DESC;

SELECT 
    stage,
    SUM(total_laid_off) as total_layoffs,
    COUNT(DISTINCT company) as num_companies,
    ROUND(AVG(percentage_laid_off), 1) as avg_pct
FROM layoffs
GROUP BY stage
ORDER BY total_layoffs DESC;

SELECT 
    year,
    month,
    SUM(total_laid_off) as monthly_layoffs
FROM layoffs
GROUP BY year, month
ORDER BY monthly_layoffs DESC
LIMIT 10;

SELECT 
    company,
    location,
    total_laid_off,
    date
FROM layoffs
WHERE year = 2023
ORDER BY total_laid_off DESC;

SELECT 
    CASE WHEN month <= 6 THEN 'H1 2023' ELSE 'H2 2023' END as half,
    SUM(total_laid_off) as total_layoffs
FROM layoffs
WHERE year = 2023
GROUP BY half;

SELECT 
    date,
    company,
    total_laid_off,
    SUM(total_laid_off) OVER (ORDER BY date) as cumulative_total
FROM layoffs
ORDER BY date;

SELECT 
    company,
    industry,
    total_laid_off,
    RANK() OVER (PARTITION BY industry ORDER BY total_laid_off DESC) as rank_in_industry
FROM layoffs
WHERE total_laid_off > 0
ORDER BY industry, rank_in_industry;

SELECT 
    company,
    location,
    total_laid_off,
    percentage_laid_off,
    date
FROM layoffs
WHERE total_laid_off > 1000
ORDER BY total_laid_off DESC;

SELECT 
    CASE 
        WHEN funds_raised_millions < 100 THEN 'Under $100M'
        WHEN funds_raised_millions < 1000 THEN '$100M-$1B'
        ELSE 'Over $1B'
    END as funding_tier,
    COUNT(*) as num_companies,
    ROUND(AVG(total_laid_off), 0) as avg_layoffs
FROM layoffs
WHERE total_laid_off > 0
GROUP BY funding_tier;
