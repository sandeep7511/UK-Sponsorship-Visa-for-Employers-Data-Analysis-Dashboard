# UK Sponsorship Visa for Employers: Data Analysis & Dashboard

## Project Overview
This project provides a comprehensive data analysis of the UK sponsorship visa system, specifically focusing on study (CAS) and work (CoS) sponsorships. By processing historical government data through SQL Server and visualizing it in Microsoft Power BI, the project uncovers long-term trends, quarter-over-quarter dynamics, nationality concentrations, and sectoral dependencies affecting UK immigration.

## Data Source
The data was sourced from the official UK government open data portal (Data.gov.uk). It comprises four primary datasets covering:
* **Study Sponsorship Data (CAS):** Application volumes by institution type, geographical region, and applicant nationality.
* **Work Sponsorship Data (CoS):** Application volumes by visa category, industry, geographic region, and applicant nationality.

## Technologies and Tools
* **Microsoft SQL Server:** Used for data ingestion, rigorous data cleaning, and transformation.
* **Microsoft Power BI:** Used for data modeling (star-schema), creating DAX measures, and developing an interactive, multi-page dashboard.

## Methodology

### 1. Data Cleaning & Transformation (SQL Server)
* Standardized numerical data by removing formatting characters (e.g., commas) and converting string columns to integer data types.
* Extracted chronological quarter numbers to enable accurate time-series sorting and calculations.
* Created unified SQL views utilizing `UNION ALL` to combine underlying tables into standardized fact structures for seamless Power BI integration.

### 2. Data Modeling (Power BI)
* Established a Star-Schema data model connecting the unified fact tables to various dimension tables including Date, Nationality, Geographical Region, Institution Type, Industry, and Leave Category.
* Developed custom DAX measures to calculate metrics such as Total Applications, Study to Work Ratio, and Quarter-over-Quarter (QoQ) Growth.

### 3. Dashboard Visualization
* Designed an interactive executive overview tracking a total volume of over 16 million applications.
* Built dedicated views for both Study Sponsorships and Work Sponsorships to isolate trends and demographic shifts.

## Key Findings & Insights
* **Study vs. Work Dominance:** Study sponsorships represent the largest component of migration, accounting for 64% of total applications (a 1.74 to 1 ratio compared to work).
* **Nationality Concentration:** * *Study Visas:* The vast majority of applications originate from China, followed by India and Nigeria.
    * *Work Visas:* India leads work sponsorship demand by a significant margin, followed by the United States and Nigeria.
* **Sectoral Dependence:** The UK university sector (Higher Education) drives study sponsorships, while the 'Human Health and Social Work' and 'Information and Communication' sectors are major drivers for work sponsorships.
* **Recent Growth:** Both study and work applications exhibit exceptional quarter-over-quarter growth post-2020, reflecting responses to recent UK immigration policy changes and labor market demands.
