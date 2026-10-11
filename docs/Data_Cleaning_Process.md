# Data Cleaning & Transformation Process

This document outlines the end-to-end data engineering, wrangling, and transformation methodology applied to raw SEC EDGAR financial filings before loading them into Google BigQuery and Power BI.

---

## 1. Data Ingestion & Raw Payload Staging
* **Data Source:** Official public RESTful SEC EDGAR API (`https://data.sec.gov/`).
* **Raw Extraction:** Financial statement facts and corporate metadata were extracted as raw JSON payloads via Python scripts.
* **Primary Key Alignment:** Standardized primary entities using CIK (Central Index Key) mapping and official stock ticker symbols (`Ticker`).

---

## 2. Data Cleaning & Integrity Checks

### A. Fiscal Calendar & Filing Normalization
* **Form 10-K Filtering:** Filtered data exclusively for annual SEC Form 10-K reports to eliminate quarterly noise (Form 10-Q) and ensure standardized 12-month fiscal period comparisons.
* **Fiscal Year Extraction:** Used BigQuery SQL functions (`EXTRACT(YEAR FROM Date)`) to normalize reporting dates into uniform fiscal reporting years (`year_report`).

### B. Missing Value & Null Treatment
* **Null Value Elimination:** Filtered out unmapped, corrupt, or missing financial metrics using `WHERE Value_USD IS NOT NULL` to maintain strict statistical integrity.
* **Metric Mapping Validation:** Verified that raw SEC tags correctly mapped to essential line items (`Assets`, `Liabilities`, `StockholdersEquity`, `Revenue`, `Net Income`, `GrossProfit`).

### C. Scaling & Anomaly Treatment
* **Unit Standardization:** Raw SEC values are reported in exact USD amounts. To enhance dashboard readability and prevent visual clutter in executive reports, figures were programmatically converted to **Billions USD** using `ROUND(MAX(Value_USD)/1000000000, 2)`.
* **Outlier Handling:** Addressed extreme corporate restatements and non-operating accounting anomalies by aggregating metric maximums per reporting cycle.

---

## 3. SQL Data Transformation Pipeline (Google BigQuery)

The data pipeline was executed in BigQuery through a two-stage SQL transformation workflow:

### Step 1: Merging Financial Metrics with Corporate Metadata
```sql
CREATE OR REPLACE TABLE `first-case-study-485421.portfolio_data.transformed_financial_data` AS
SELECT * 
FROM `first-case-study-485421.portfolio_data.sec_financial_metrics`
LEFT JOIN `first-case-study-485421.portfolio_data.company_info`
USING(Ticker);
```
### Step 2: Final Cleaning, Scaling, and Aggregation
```sql
CREATE OR REPLACE TABLE `first-case-study-485421.portfolio_data.final_financial_data` AS
SELECT
    Ticker,
    Company_Name,
    EXTRACT(YEAR FROM Date) AS year_report,
    Metric,
    ROUND(MAX(Value_USD)/1000000000, 2) AS value_in_billions
FROM `first-case-study-485421.portfolio_data.transformed_financial_data`
WHERE Value_USD IS NOT NULL
GROUP BY Ticker, Company_Name, year_report, Metric
ORDER BY Ticker, Company_Name, year_report, Metric;
```
---

## 4. Final Output Verification
* **Destination Table:** first-case-study-485421.portfolio_data.final_financial_data
* **Downstream Integration:** Directly imported into Power BI to serve as the core transactional table for custom DAX measures (e.g., ROA, ROE, Debt-to-Equity, Net Profit Margin).



