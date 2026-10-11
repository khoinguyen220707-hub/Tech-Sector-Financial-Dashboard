-- ============================================================
-- STEP 1: JOIN COMPANY INFORMATION WITH SEC FINANCIAL DATA
-- ============================================================

```sql
CREATE OR REPLACE TABLE
  `first-case-study-485421.portfolio_data.transformed_financial_data` AS

SELECT *
FROM `first-case-study-485421.portfolio_data.company_info`
LEFT JOIN `first-case-study-485421.portfolio_data.sec_financial_metrics`
USING (Ticker);
```

-- ============================================================
-- STEP 2: CLEAN AND AGGREGATE DATA FOR POWER BI
-- ============================================================

```sql
CREATE OR REPLACE TABLE
  `first-case-study-485421.portfolio_data.final_financial_data` AS

SELECT
    Ticker,
    Company_Name,
    EXTRACT(YEAR FROM Date) AS year_report,
    Metric,
    ROUND(MAX(Value_USD) / 1000000000, 2) AS value_in_billions
FROM `first-case-study-485421.portfolio_data.transformed_financial_data`
WHERE Value_USD IS NOT NULL
GROUP BY
    Ticker,
    Company_Name,
    year_report,
    Metric
ORDER BY
    Ticker,
    Company_Name,
    year_report,
    Metric;
```
