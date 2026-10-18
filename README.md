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
- **visualisation Tool:** PowerBI
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
```
📊 Dataset Summary (Results)

Total employees laid off: 752,040

Companies included: 2,673

Countries represented: 2,673

Industries represented: 2,672

Largest single layoff event (example): Intel, 2025, Hardware industry

🔎 Analysis Results
1. Overall Analysis
    Total employees laid off: 752,040
    
    Companies in dataset: 2,673
    
    Countries represented: 2,673
    
    Industries represented: 2,672
    
    Largest single layoff event: Intel, 2025, Hardware

2. Time-Based Analysis
    Year with highest layoffs: 2023 → 264,220
    
    Other years:
    
    2024 → 152,922
    
    2025 → 72,808
    
    2022 → 165,269
    
    2021 → 15,823
    
    2020 → 80,998

📈 Insight: Layoffs peaked in 2023, then declined in 2024–2025.

3. Company Analysis

    ### Top 10 Companies by Layoffs

| Company     | Total Laid Off |
|-------------|----------------|
| Intel       | 38,115         |
| Microsoft   | 30,013         |
| Amazon      | 27,940         |
| Google      | 13,547         |
| Salesforce  | 12,140         |
| Uber        | 7,785          |
| Bytedance   | 5,700          |
| Redfin      | 2,347          |
| ShareChat   | 958            |
| AppLovin    | 790            |



📌 Insight: Intel had the largest layoffs overall, followed by Microsoft and Amazon.

4. Industry Analysis
    Industries represented: 2,672
    
    Highest layoff industry (example from dataset): Hardware (Intel event)
    
    Industry-level breakdown can be computed with:

sql
```
SELECT industry, SUM(laid_off_count) 
FROM company_layoffs 
GROUP BY industry 
ORDER BY SUM(laid_off_count) DESC;
 ```

5. Country Analysis
    Countries represented: 2,673
    
    Largest single layoff country (example): United States (Intel, 2025)

Top 10 countries query:

sql
```
SELECT country, SUM(laid_off_count) 
FROM company_layoffs 
GROUP BY country 
ORDER BY SUM(laid_off_count) DESC 
LIMIT 10;
```
6. Funding Stage Analysis
    Funding stage queries show which stages (Seed, Series A/B/C, Post-IPO) had the most layoffs.

Example query:

sql
```
    SELECT funding_stage, SUM(laid_off_count) 
    FROM company_layoffs 
    GROUP BY funding_stage 
    ORDER BY SUM(laid_off_count) DESC;
```
7. Funding vs Layoffs
    Companies with high funding but large layoffs can be identified with:

sql
```
SELECT company, funding_stage, funding_usd_millions, laid_off_count 
FROM company_layoffs 
WHERE funding_usd_millions >= 100 AND laid_off_count >= 500;
```
📌 Insight: Some highly funded companies (e.g., Intel, Microsoft, Amazon) still experienced significant layoffs.

✅ Key Insights
    Layoffs peaked in 2023 with 264,220 employees affected.
    
    Intel, Microsoft, and Amazon were the most impacted companies.
    
    The United States recorded the largest single layoff event.
    
    Layoffs spanned 2,673 companies, 2,673 countries, and 2,672 industries.
    
    Funding stage analysis shows that even highly funded companies faced large layoffs.



## 📑 Power BI Dashboard Pages

### Page 1 – Executive Overview
- KPI Cards: Total Employees Laid Off, Companies, Countries, Industries  
- Line Chart: Yearly Layoffs Trend  
- Bar Chart: Top 10 Companies  

### Page 2 – Industry & Company Analysis
- Bar Chart: Top Industries by Layoffs  
- Donut Chart: Industry % Contribution  
- Heatmap: Average Layoff % by Industry  
- Drill-down with Year Filter  

### Page 3 – Geographic & Funding Analysis
- Map: Layoffs by Country  
- Bar Chart: Top Countries by Layoffs  
- Stacked Bar Chart: Layoffs by Company Stage  
- Scatter Plot: Funds Raised vs. Layoffs  

---
 

### 3. Create Measures (DAX)
```DAX
Total Laid Off = SUM(company_layoffs[laid_off_count])
Total Companies = DISTINCTCOUNT(company_layoffs[company])
Total Countries = DISTINCTCOUNT(company_layoffs[country])
Total Industries = DISTINCTCOUNT(company_layoffs[industry])


