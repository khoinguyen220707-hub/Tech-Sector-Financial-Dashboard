# Data Source & Regulatory Compliance

---

## 1. Data Origin
* **Provider:** U.S. Securities and Exchange Commission (SEC)
* **Database:** EDGAR (Electronic Data Gathering, Analysis, and Retrieval system)
* **Access Method:** Official Public SEC RESTful API (`[https://data.sec.gov/](https://data.sec.gov/)`)
* **Coverage Period:** Fiscal Years 2020 – 2026
* **Target Entities:** 500+ Publicly Traded Technology Enterprises (US Listed)

---

## 2. API Usage & Compliance
* **User-Agent Standard:** Requests submitted through automated Python scripts strictly adhere to SEC EDGAR access guidelines by including required User-Agent headers.
* **Rate Limiting:** Data extraction pipelines incorporate request throttling to remain well under the SEC limit of 10 requests per second.

---

## 3. Disclaimer
This dataset and project are constructed strictly for educational, portfolio, and analytical purposes using publicly accessible regulatory filings.
