# Tech-Sector Financial Dashboard

### Data Analytics & Finance Personal Project

An end-to-end financial analytics project using **Python, SEC EDGAR data, Google BigQuery, DAX, and Power BI** to explore company profitability, capital structure, and financial efficiency.

As a sophomore majoring in Data Analytics and Finance, I built this project to practice transforming public financial statement data into an analytical dataset and an interactive dashboard.

## Project Overview

The final project expanded SEC financial-data collection to approximately **500 companies**.

The underlying dataset contains historical financial observations beyond the dashboard's selected display window. Relevant Power BI visuals focus on **2020–2026** to make recent trends easier to compare.

This date range is applied in Power BI rather than in the Python extraction or SQL transformation. Coverage varies by company, reporting year, and metric; 2026 includes only available observations and should not be interpreted as a complete fiscal year for every company.

The notebook shared for this project contains an earlier five-company extraction prototype using AAPL, MSFT, GOOGL, TSLA, and AMZN. The final dataset was collected using an expanded company list.

## Business Questions

1. How has company profitability changed across available reporting years?
2. How do companies compare on Net Profit Margin, ROA, ROE, and Asset Turnover?
3. What patterns appear when comparing liabilities relative to equity with accounting ROE?
4. How can revenue-based firm-size categories help organize financial comparisons?

## Tech Stack & Tools

| Stage | Tools | Purpose |
| --- | --- | --- |
| Data extraction | Python, requests, pandas, Jupyter Notebook | Retrieve and reshape SEC financial observations |
| Initial prototype | SQLite | Store and query an Apple Net Income sample |
| Data loading | pandas-gbq | Upload financial records to Google BigQuery |
| Data transformation | SQL, Google BigQuery | Join metadata, filter missing values, group observations, and convert USD to billions |
| Financial modeling | DAX | Calculate financial ratios and classification columns |
| Visualization | Power BI | Build interactive financial comparisons |
| Documentation | Markdown, GitHub | Explain the workflow and analytical assumptions |

## Data Source

- **Origin:** U.S. Securities and Exchange Commission (SEC) EDGAR Company Facts API.
- **Identifiers:** Company tickers are mapped to SEC Central Index Key (CIK) identifiers.
- **Financial observations:** Available USD facts associated with `10-K` filings.
- **Extracted metrics:** Net Income, Revenue, Assets, Gross Profit, Liabilities, and Stockholders' Equity.
- **Company metadata:** A separately prepared table containing company tickers and names.

Available metrics and reporting periods differ across companies. The dataset is a selected company universe rather than a verified, complete census of the technology sector.

More details: [Data Source](02_docs/Data_Source.md).

## Data Analysis Workflow

### 1. Ask

Define questions about company profitability, balance-sheet leverage, and financial efficiency.

The objective is to build an analytical workflow that connects public financial data with interactive company-level comparisons.

### 2. Prepare

- Resolve ticker symbols to SEC CIK identifiers.
- Retrieve Company Facts JSON using Python.
- Extract available financial metrics in USD.
- Retain observations associated with `10-K` filings.
- Reshape the extracted records into:
  - `Ticker`
  - `Date`
  - `Metric`
  - `Value_USD`
- Load financial observations into Google BigQuery.
- Prepare company metadata separately for the ticker-based join.

### 3. Process

- Left-join company metadata with financial observations using `Ticker`.
- Remove records with missing financial values.
- Extract the calendar year from each observation's period-end date.
- Group records by ticker, company name, reporting year, and metric.
- Select the maximum observed value within each group.
- Convert USD values to billions and round to two decimal places.

The final output is stored in `final_financial_data`.

More details: [Data Cleaning Process](02_docs/Data_Cleaning_Process.md).

### 4. Analyze

Use DAX to calculate:

- Net Profit Margin
- Return on Assets (ROA)
- Return on Equity (ROE)
- Asset Turnover Ratio
- A liabilities-to-equity ratio labeled D/E in the report
- Percentage of Profitable Companies

Calculated columns classify Net Income observations as Profit or Loss and assign custom firm-size categories based on average revenue.

### 5. Share

Present the analysis through an interactive Power BI dashboard with:

- Year and company slicers
- Financial KPI cards
- Profitability trends
- A leverage-versus-ROE scatter plot
- Revenue-based firm-size categories
- A company financial-ratio comparison matrix

Relevant visuals use a 2020–2026 display window, while the underlying dataset retains a longer history.

### 6. Act

Use the report to identify patterns and companies that warrant further investigation.

Potential follow-up work includes checking metric completeness, reconciling selected values with original filings, and improving annual-observation selection before drawing broader conclusions.

## Dashboard

**Power BI report:** [SEC_dashboard.pbix](04_dashboard/SEC_dashboard.pbix)

| Component | What it displays |
| --- | --- |
| KPI cards | Percentage of Profitable Companies, Net Profit Margin, ROA, and ROE |
| Profitability Trends | Net Profit Margin and ROA across reporting years |
| Risk vs. Return Analysis | Liabilities-to-equity versus accounting ROE, with Asset Turnover in the tooltip |
| Firm Size Distribution | Revenue-based categories using the current visual's record counts |
| Company comparison matrix | Asset Turnover, Net Profit Margin, ROA, ROE, and the D/E measure |

The scatter plot compares accounting measures. It does not calculate stock-market volatility or investment returns.

The current firm-size distribution visual counts nonblank company-name records rather than distinct companies. Its percentages therefore represent record shares.

## Repository Structure

```text
Tech-Sector-Financial-Dashboard/
├── 01_data/
│   ├── raw/
│   │   ├── company_name_raw.csv
│   │   └── financial_metrics_raw.csv
│   └── processed/
│       └── final_financial_data.csv
├── 02_docs/
│   ├── Data_Cleaning_Process.md
│   ├── Data_Source.md
│   └── Financial_Metrics_Glossary.md
├── 03_src/
│   ├── powerbi/
│   │   └── dax_measures.dax
│   ├── python/
│   │   └── sec_scraper.ipynb
│   └── sql/
│       └── financial_transform.sql
├── 04_dashboard/
│   └── SEC_dashboard.pbix
├── LICENSE
└── README.md
```

- **01_data:** Raw financial records, company metadata, and the processed dataset.
- **02_docs:** Data-source information, transformation notes, and financial metric definitions.
- **03_src:** Python extraction code, SQL transformations, and DAX formulas.
- **04_dashboard:** The completed Power BI report.
- **LICENSE:** Terms for using and sharing the project.
- **README.md:** Project overview, workflow, and usage instructions.

## Technical Implementation

### SQL Transformation

The SQL script runs in two stages:

1. Join `company_info` with `sec_financial_metrics` using `Ticker` to create `transformed_financial_data`.
2. Filter and group the joined records to create `final_financial_data`.

The value transformation is:

```sql
ROUND(MAX(Value_USD) / 1000000000, 2) AS value_in_billions
```

`MAX()` selects the largest observed value in each company/year/metric group. It reduces multiple observations to one value but does not necessarily select the latest filing, latest restatement, or correct full-year fact.

Full implementation: [financial_transform.sql](03_src/sql/financial_transform.sql).

### DAX Financial Modeling

| Measure or column | Implementation |
| --- | --- |
| Net Profit Margin | Net Income / Revenue |
| Return on Assets (ROA) | Net Income / reported Assets |
| Return on Equity (ROE) | Net Income / reported Stockholders' Equity |
| Asset Turnover Ratio | Revenue / reported Assets |
| Debt-to-Equity Ratio (D/E) | Total Liabilities / Stockholders' Equity |
| Percentage of Profitable Companies | Distinct companies labeled Profit / distinct companies with Net Income observations |
| Business_Status | Positive Net Income → Profit; zero or negative Net Income → Loss |
| Firm_Size | Classification based on average available Revenue |

The D/E measure uses total liabilities rather than interest-bearing debt, so it is interpreted as a **liabilities-to-equity proxy**.

Firm-size thresholds are:

| Category | Average Revenue |
| --- | --- |
| Big Firm | At least $10 billion |
| Medium Firm | At least $2 billion and below $10 billion |
| Small Firm | Below $2 billion |
| Unknown | No available Revenue |

These are custom revenue-based categories rather than market-cap classifications. The calculated column is evaluated at model refresh and does not recalculate when the year slicer changes.

Full formulas: [dax_measures.dax](03_src/powerbi/dax_measures.dax).

Definitions: [Financial Metrics Glossary](02_docs/Financial_Metrics_Glossary.md).

## How to Explore the Project

1. Review the processed CSV for the analytical dataset.
2. Read the SQL script to understand the join and grouping logic.
3. Review the DAX formulas and financial-metric definitions.
4. Open `04_dashboard/SEC_dashboard.pbix` in Power BI Desktop.
5. Select a company and reporting year to inspect its financial ratios.
6. Configure your own BigQuery access if you want to refresh the report.

The prototype notebook illustrates the extraction approach. Reproducing the full approximately 500-company collection requires the expanded ticker list and extraction version used for the final dataset.

## Analytical Assumptions & Limitations

- **Reporting periods:** Filtering for `10-K` does not by itself confirm that every observation covers a full fiscal year. `year_report` is extracted from the period-end date.
- **Grouped values:** `MAX()` selects the largest value, including the least negative value when observations are losses. It is not a filing-version selection rule.
- **Metric coverage:** Missing or differently tagged SEC facts can produce incomplete comparisons.
- **Ratio denominators:** ROA, ROE, and Asset Turnover use reported closing balances rather than average opening and closing balances.
- **Aggregation:** Ratio measures divide sums within the active filter context. Totals are ratios of combined values rather than simple averages of company ratios.
- **Precision and missing results:** Values are rounded before ratio calculation, and the supplied DAX uses zero as the alternative result for zero or blank denominators.
- **Multi-year selections:** The profitability percentage counts a company as profitable if any retained Net Income observation in the selected context is positive.
- **2026 coverage:** The selected display window does not guarantee complete 2026 financial data.

These assumptions should be considered when interpreting dashboard results.

## Future Improvements

- Include the expanded extraction notebook and complete ticker list.
- Preserve fiscal-year, duration, and filing metadata for more reliable annual-fact selection.
- Expand revenue-tag coverage and add company/year/metric completeness checks.
- Retain full monetary precision until display formatting.
- Distinguish unavailable ratios from genuine zero results.
- Use distinct company counts in the firm-size distribution visual.
- Add findings supported by specific values, company selections, and reporting periods.

## Connect with Me

I am open to discussing Data Analytics, financial analysis, and internship opportunities.

- **LinkedIn:** [Nguyen Mai](https://www.linkedin.com/in/nguyen-mai-195870395/)
- **Email:** khoinguyen220707@gmail.com
- **Tableau Public:** [My visualizations](https://public.tableau.com/app/profile/nguyen.mai4551/vizzes)
