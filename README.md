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
│   ├── 📄 Data_Cleaning_Process.md       # Outlier handling & data wrangling notes
│   ├── 📄 Financial_Metrics_Glossary.md  # Definitions of ROA, ROE, D/E, etc.
│   └── 📄 Data_Source.md                 # Data origin and compliance details
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
* **Business Question:**
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?
* **Objective:** Identify trends and patterns to convert casual riders into annual members
### 2. Prepare:
* Imported 12 months of CSV files into BigQuery
* Merged datasets into a single table ('trips_2025_uncleaned') consisting of over **5.5 million** rows
* Verified schema consistency across all files
### 3.Process:
* **Cleaning:** Removed duplicates, null values, and test station entries.
* **Calculation:**
  * Extracted 'day_of_week"
  * Estimate the total rides
  * Group hours into 3 main categories
  * **Filtering:** Excluded trips shorter than 1 minute or longer than 24 hours to eliminate outliers.
### 4. Analyze:
* **Data Aggregation:** Perform calculations for the duration intensity
* **Pivot Analysis:** Using pivot tables to search for overall insights through statistical numbers
* **Key Findings:**
  * **Annual members** are the majority in the distribution
  * **Members** shows a consistent pattern during weekdays, while **Casuals** show a peaking on weekends afternoons.
  * Both **casual riders** and **annual members** show a preference for electric bikes
  * **Casual riders** travel **2x longer** on average compared to members, but the frequency is lower
  * Top 3 stations for **casual riders** are all near **recreational areas**
### 5. Share
* **Visualization tool:** Developed simple and accesible charts through **Excel** and interactive dashboard using **Tableau**
* **Design Philosophy:** Applied "Data-to-Ink Ratio" principles to ensure clarity and focus on key trends
* **Visual storytelling:** Displayed all the findings and insights in a structured and logical way through **Microsoft PowerPoint**
* **Dashboard Link:**
 * **Temporal Analysis:** https://public.tableau.com/app/profile/nguyen.mai4551/vizzes
 * **Geographic Analysis:** https://public.tableau.com/app/profile/nguyen.mai4551/viz/Book2_17700077149760/Sheet1
### 6. Act
1. **Weekend Membership Plan:** Launch a "Weekend-Only" membership tier or a "Summer Pass" specifically targeting casual riders who follow these patterns
2. **Strategic Trial Campaign:** Focus and promote digital marketing of  efforts, especially near recreational areas and tourist attractions most frequented by casual riders
3. **Gamification & Reward System:** Offer captivating and impressive rewards or discounts to casual riders who bike frequently
## 7. SQL Highlights
``` SQL
-- Calculating trips by duration to identify usage patterns
CREATE OR REPLACE TABLE `first-case-study-485421.cyclistic_tripdata_2025.trips_2025_User_frequency` AS
(
SELECT
  EXTRACT(MONTH FROM started_at ) AS Month,
  member_casual,
  ROUND(MAX(TIMESTAMP_DIFF(ended_at, started_at, SECOND)/60), 2) AS max_length,
  ROUND(MIN(TIMESTAMP_DIFF(ended_at, started_at, SECOND)/60), 2) AS min_length,
  ROUND(AVG(TIMESTAMP_DIFF(ended_at, started_at, SECOND)/60), 2) AS mean_length,
  ROUND(SUM(TIMESTAMP_DIFF(ended_at, started_at, SECOND)/60), 2) AS total_length
FROM `first-case-study-485421.cyclistic_tripdata_2025.trips_2025_cleaned`
GROUP BY month, member_casual
ORDER BY month
```
## 8. Connect with Me
I am always open to discussing Data Analytics, networking, or internship opportunities
* **LinkedIn:** https://www.linkedin.com/in/nguyen-mai-195870395/
* **Interactive Portfolio:**
* **Email:** khoinguyen220707@gmail.com
* **Tableau Public:** https://public.tableau.com/app/profile/nguyen.mai4551/vizzes
