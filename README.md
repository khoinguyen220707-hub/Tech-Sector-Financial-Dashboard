# Tech-Sector-Financial-Dashboard
### Data Analytics and Finance Personal Project
## Project Overview
As a sophomore **Data** Analytics and **Finance** major, I built a high-quality, SaaS-standard Power BI dashboard to analyze the financial health, profitability trends, and capital risk profiles of 500+ tech companies from 2020 to 2026

The goal of this analysis is to bridge the gap between raw financial data engineering and executiave business intelligence, delivering actionable insights for data-driven and strategic investment decisions.

## Tech Stack & Tools:
* **Data Processing:** SQL (Google BigQuery) and Jupyter Notebook(VS Code), DAX(Power Query)
* **Visualization:** Power BI
* **Documentation:** Google Docs and Github

## Project structure:
```
Tech-Sector-Financial-Dashboard/
│
├── data/                  
│   ├── raw/                           # Original financial statements and company info
│   └── processed/                     # Cleaned datasets with handled outliers
│
├── docs/                  
│   ├── Data_Cleaning_Process.md       # Outlier handling & data wrangling notes
│   ├── Financial_Metrics_Glossary.md  # Definitions of ROA, ROE, D/E, etc.
│   └── Data_Source.md                 # Data origin and compliance details
│
├── dashboard/             
│   └── Tech_Financial_Dashboard.pbix
│
├── dax/                   
│   └── calculated_measures.dax       # Custom DAX formulas
│
└── README.md                         # Project overview
```
## Data Source:
* **Origin:** U.S. Securities and Exchange Commission (SEC) EDGAR Database via SEC API.
* **Scope & Entities:** Financial statements of major technology companies, covering the period from 2020 to 2026.
* **Data Integrity:** The raw JSON/text data extracted directly from SEC filings was programmatically cleaned, filtered for annual reports, mapped to standardized structural schemas, and verified for consistency to eliminate missing or corrupted records.

## The 6-Step Data Analysis Process

### 1. Ask
- **Business Questions:**
  1. Which tech sub-sectors demonstrated the highest profitability resilience and Net Income growth from 2020 to 2026?
  2. How do capital structures (Debt-to-Equity ratios) impact the risk and return profiles across different tech market caps?
  3. What actionable insights can investors derive regarding capital allocation and risk mitigation in the tech sector?
- **Objective:** Build an end-to-end analytical framework and Power BI dashboard to evaluate tech sector performance and guide strategic investment decisions.

### 2. Prepare:
- Extracted multi-year financial statements and metadata from SEC EDGAR API into Google BigQuery.
- Aggregated raw records into standardized master tables consisting of hundreds of tech enterprises.
- Verified schema consistency, currency units, and fiscal year alignment across all entities.

### 3. Process:
- **Cleaning:** Handled missing values, normalized divergent fiscal calendars, and treated structural outliers in financial metrics.
- **Calculation & Transformation:**
  * Engineered core financial ratios (ROA, ROE, Debt-to-Equity, Profit Margins) using SQL and Power Query.
  * Filtered out distorted entities, extreme anomalies, and unmapped corporate filings to guarantee data fidelity.

### 4. Analyze:
- **Data Aggregation:** Computed multi-year moving averages and sector benchmarks for profitability and risk metrics.
- **Key Findings:**
  * **Profitability Concentration:** A small percentage of mega-cap tech companies drive the majority of sector-wide net income growth.
  * **Risk Profiles:** High-growth firms exhibit higher volatility in Debt-to-Equity ratios during macroeconomic shifts.
  * **Capital Efficiency:** Distinct divergence in ROE performance between hardware-heavy and software-as-a-service (SaaS) tech verticals.

### 5. Share
- **Visualization Tool:** Developed an interactive, SaaS-standard executive dashboard using **Power BI**.
- **Design Philosophy:** Applied clean visual hierarchy, effective color-coding, and custom DAX measures to highlight key financial KPIs without clutter.
- **Visual Storytelling:** Structured the dashboard to guide investors seamlessly from high-level macroeconomic tech trends down to individual company financials.
- **Dashboard Link:** *(Insert your Power BI Public/Web Link here if applicable)*

### 6. Act
1. **Strategic Capital Allocation:** Advise investors to diversify across resilient software sub-sectors while carefully monitoring debt exposure in hardware-centric tech firms.
2. **Risk Monitoring Framework:** Establish threshold-based alerts using key ratios (like D/E and ROA) for continuous portfolio risk evaluation.
3. **Future Expansion:** Integrate real-time SEC automated ingestion pipelines to keep the dashboard updated dynamically as upcoming quarterly/annual reports are filed.

## 7. SQL Highlights
### Step 1: Merging Financial Metrics with Company Metadata
```sql
CREATE OR REPLACE TABLE `first-case-study-485421.portfolio_data.transformed_financial_data` AS
SELECT * 
FROM `first-case-study-485421.portfolio_data.sec_financial_metrics`
LEFT JOIN `first-case-study-485421.portfolio_data.company_info`
USING(Ticker);
```

### Step 2: Cleaning, Transforming, and Creating the Final Table
```sql
CREATE OR REPLACE TABLE `first-case-study-485421.portfolio_data.final_financial_data` AS
SELECT
    Ticker,
    Company_Name,
    EXTRACT(YEAR FROM Date) AS year_report,
    Metric,
    ROUND(MAX(Value_USD)/1000000000,2) AS value_in_billions
FROM `first-case-study-485421.portfolio_data.transformed_financial_data`
WHERE Value_USD IS NOT NULL
GROUP BY Ticker, Company_Name, year_report, Metric
ORDER BY Ticker, Company_Name, year_report, Metric;
```
## 8. Connect with Me
I am always open to discussing Data Analytics, networking, or internship opportunities
* **LinkedIn:** https://www.linkedin.com/in/nguyen-mai-195870395/
* **Email:** khoinguyen220707@gmail.com
* **Tableau Public:** https://public.tableau.com/app/profile/nguyen.mai4551/vizzes
