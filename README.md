# Customer Retention Analysis and Visualization Project for Delivery Platform for Food and Merchandise

This project is part of the BI Developer Internship 2022 assignment. The goal is to analyze customer retention and build insightful visualizations based on provided datasets.

## Project Overview

The analysis focuses on:
- Cohort-based monthly retention for Retail product line.
- Cohort-based monthly retention for Restaurant product line.

## Data Description

The data consists of two CSV files:
- `first_purchases.csv`
- `purchases.csv`

### Fields in `first_purchases.csv`:
- **First Purchase Date:** Date (UTC) when a user made their first purchase.
- **First Purchase Product Line:** Product line of the first purchase (`Restaurant` or `Retail store`).
- **User ID:** Unique ID of the user.
- **Purchase ID:** Unique ID of the purchase.
- **Venue ID:** Unique ID of the venue where the purchase was made.

### Fields in `purchases.csv`:
- **Purchase Date:** Date (UTC) of the purchase.
- **Product Line:** Product line of the purchase (`Restaurant` or `Retail store`).
- **User ID:** Unique ID of the user.
- **Purchase ID:** Unique ID of the purchase.
- **Venue ID:** Unique ID of the venue where the purchase was made.

## SQL Analysis

The SQL script (`Cohort_Analysis.sql`) provided in this repository includes the following sections:
1. **Bucketing:** Assigns users to cohorts based on their first purchase month.
2. **User Activity:** Identifies active months for users after their first purchase.
3. **Cohort Size:** Calculates the size of each cohort.
4. **Final Cohort Retention Table:** Combines the data to calculate monthly retention rates.

## How to Run the SQL Script

1. Ensure you have access to a SQL environment (e.g., PostgreSQL, MySQL).
2. Load the datasets (`first_purchases.csv` and `purchases.csv`) into corresponding tables (`first_purchase` and `purchase`).
3. Run each section of the SQL script in sequence to avoid errors.

## Visualization

The resulting data from the SQL script is used to create visualizations in Tableau. The visualizations illustrate the monthly retention rates for both Retail and Restaurant product lines, helping to understand customer behavior and retention dynamics.

## Deliverables

1. **SQL Script:** [Cohort_Analysis.sql](Cohort_Analysis.sql)
2. **Tableau Visualizations:** Link to Tableau visualizations or screenshots of the visualizations.

## Assumptions and Data Issues

- Assumptions made about the data are documented within the SQL script.
- Any data inconsistencies encountered have been addressed in the analysis process.

## Improvements

- Additional data sources or business information that could improve the solution:
  - Customer demographics
  - Marketing campaign data
  - Customer feedback and ratings

## Feedback and Contributions

Feel free to open an issue or submit a pull request if you have any suggestions or improvements.


