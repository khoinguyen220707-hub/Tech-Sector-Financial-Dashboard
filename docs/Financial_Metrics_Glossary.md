# Financial Metrics Glossary

This document provides complete definitions, formulas, and operational logic for all raw SEC financial metrics and DAX calculated measures used in the **Tech Sector Financial Dashboard**.

---

## 1. Primary SEC Raw Metrics (BigQuery Ingestion)

These core financial line items are extracted directly from official SEC Form 10-K filings via the SEC EDGAR API and stored in BigQuery.

* **StockholdersEquity (USD):** Total residual interest in the assets of the company after deducting all liabilities (Assets - Liabilities).
* **Assets (USD):** Total economic resources owned or controlled by the enterprise expected to produce future economic benefits.
* **Liabilities (USD):** Total financial debts and obligations owed by the enterprise to external parties.
* **Revenue (USD):** Total gross inflow of economic benefits arising from primary business operations.
* **Net Income (USD):** Total net earnings/profit remaining after deducting all operating expenses, taxes, interest, and costs from revenue.
* **GrossProfit (USD):** Direct profit generated after subtracting the Cost of Goods Sold (COGS) from Total Revenue.

---

## 2. Calculated Financial Ratios & Performance Indicators (Power BI Measures)

### **Profitability Metrics**
* **Net Profit Margin (%)**
  * **Formula: Net Income \ Revenue
  * **Description:** Measures the percentage of total revenue converted into net profit. Evaluates overall cost management and operational efficiency.
* **Return on Assets (ROA)**
  * **Formula: Net Income \ Assets
  * **Description:** Evaluates asset utilization efficiency by calculating how much net income is generated per dollar of corporate assets.
* **Return on Equity (ROE)**
  * **Formula:** Net Income \ StockholdersEquity
  * **Description:** Key investor metric measuring management efficiency in generating profits from shareholder-contributed capital.
* **% Profitable Companies**
  * **Description:** Aggregate benchmark calculating the percentage of tech companies within a sub-sector or market-cap group that generated a positive Net Income ($> 0$).

---

### **Efficiency & Leverage Metrics**
* **Debt-to-Equity (D/E) Ratio**
  * **Formula:** Liabilities \ StockholdersEquity
  * **Description:** Measures corporate financial leverage and capital structure risk, comparing total debt obligations against owner equity.
* **Asset Turnover Ratio**
  * **Formula:** Revenue \ Assets
  * **Description:** Assesses revenue generation capacity per dollar of total corporate assets.

---

## 3. Dimensional Categorization & Data Attributes

* **Firm_Size:** Categorizes companies by market cap or balance sheet size (e.g., Mega-Cap, Large-Cap, Mid-Cap) to enable peer-group benchmarking.
* **Business_Status:** Operational health classification (e.g., Profitable vs. Loss-Making / Distressed) based on multi-year Net Income and leverage thresholds.
* **value_in_billions:** Standardized metric scaling raw financial figures into billions of USD (Value_USD $1,000,000,000) for clean visual representation.
* **year_report:** Fiscal year reporting period extracted from SEC filing timestamps.
* **Ticker & Company_Name:** Official stock exchange ticker symbol and legal corporate entity name.
