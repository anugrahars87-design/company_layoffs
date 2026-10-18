# 📘 Global Tech Layoffs Analysis (SQL Project)

## 📂 Overview
This project uses SQL to analyze global technology layoffs.  
The goal is to answer key business questions such as:
- Total employees laid off
- Companies, countries, and industries affected
- Yearly and monthly layoff trends
- Top companies and industries by layoffs
- Geographic distribution
- Relationship between funding stage and layoffs

---

## 🛠 Tech Stack
- **Database:** PostgreSQL  
- **Schema:** `company_layoffs`  
- **Tools:** pgAdmin / DBeaver / SQLTools  

---

## 📊 Database Schema
```sql
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
