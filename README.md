# Superstore-End-to-End-Data-Analytics
Tools: Excel · MySQL · Python · Power BI A business-focused analysis of sales, profitability, customers, products, regions, shipping, and returns, using a repeatable workflow from raw data to an interactive executive report.

# Superstore End-to-End Data Analytics Project

## Overview

This project analyzes retail sales and profitability using **Excel, MySQL, Python, and Power BI**. It demonstrates an end-to-end data analytics workflow, from raw dataset inspection and data quality validation to SQL-based analysis, Python exploratory data analysis, interactive dashboards, and business recommendations.

The objective is to understand sales performance, profit margins, category and sub-category contribution, regional differences, customer segments, shipping patterns, and returned orders.

## Business Objectives

- Analyze overall sales, profit, profit margin, quantity, and order volume.
- Identify high-performing and loss-making product categories and sub-categories.
- Compare regional sales and profitability.
- Evaluate customer-segment and shipping-mode performance.
- Analyze monthly sales and profit trends.
- Examine returned orders and their relationship to business performance.
- Develop interactive Power BI reports to support business decision-making.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Initial inspection, data validation, cleaning, and exploratory analysis |
| MySQL | Data storage, joins, aggregations, CTEs, subqueries, window functions, and analytical queries |
| Python | Pandas-based data preparation, exploratory analysis, validation, and visualizations |
| Power BI Desktop | Power Query transformations, dimensional modeling, DAX measures, and interactive reports |
| Power BI Service | Report publication and sharing, where account and licensing permissions allow |
| Git and GitHub | Version control and project documentation |

## Dataset

The project uses a Sample Superstore retail dataset containing order-level details such as:

- Order ID and order date
- Ship date and ship mode
- Customer ID, customer name, and segment
- Geographic information, including region and state
- Product category and sub-category
- Sales, quantity, discount, and profit
- Return information, where available
- Regional manager information, where provided

The dataset is commonly distributed in Excel format, but column names and row counts may vary between versions.

**Data source:** [Insert the exact dataset source URL used]

If the dataset cannot be redistributed, download it from the original source and place the permitted source files in `data/raw/`.

## Project Workflow

### 1. Excel — Initial Data Inspection

- Inspected source worksheets and column structures.
- Reviewed data types, blank values, duplicate records, and key fields.
- Checked date and numeric fields for consistency.
- Reviewed repeated order identifiers and distinguished legitimate line items from duplicate records.
- Documented data quality observations before downstream analysis.

### 2. MySQL — Data Preparation and Analysis

- Created the project database and imported the source tables.
- Validated row counts, keys, missing values, and duplicate patterns.
- Used filtering, aggregation, grouping, and sorting for foundational analysis.
- Applied joins to analyze orders alongside customer, product, regional, and return information.
- Used subqueries, CTEs, and window functions for more advanced analytical questions.
- Exported query results for validation and downstream reporting where required.

### 3. Python — Exploratory Data Analysis

- Used Pandas and NumPy for data inspection and analysis.
- Validated column types, missing values, duplicate patterns, and analytical grain.
- Analyzed sales and profit across time, categories, sub-categories, regions, and segments.
- Used Matplotlib and Seaborn for exploratory visualizations where appropriate.
- Compared selected Python results with SQL aggregates to check consistency.

### 4. Power BI — Data Modeling and Reporting

- Imported the relevant data tables and transformed them using Power Query.
- Created a dimensional model with a sales fact table and supporting dimensions.
- Configured relationships and checked key uniqueness.
- Created DAX measures for sales, profit, profit margin, orders, quantity, returned orders, and return rate.
- Built executive and detailed analytical report pages.
- Added slicers, trend analysis, conditional formatting, tooltips, drill-down, and drill-through where implemented.
- Created time-intelligence and target-analysis measures where the necessary date and target data were available.

### 5. Power BI Service — Publication

- Saved the Power BI Desktop report as a `.pbix` file.
- Published the report to an available workspace, if supported by the account.
- Validated published visuals, slicers, and report interactions.
- Reviewed source credentials and refresh requirements.
- Documented access and refresh limitations.

## Power BI Report Pages

1. **Executive Overview:** High-level sales, profit, margin, orders, quantity, and returns.
2. **Category Analysis:** Sales and profitability by category and sub-category.
3. **Regional Analysis:** Comparison of sales, profit, and margins across regions.
4. **Product Detail:** Product-level sales, profit, and profitability analysis.
5. **Order Details:** Transaction-level information, shipping details, and return status.

Include only the pages that exist in the submitted PBIX file.

## Core DAX Measures

```DAX
Total Sales =
SUM(FactSales[Sales])
```

```DAX
Total Profit =
SUM(FactSales[Profit])
```

```DAX
Profit Margin =
DIVIDE([Total Profit], [Total Sales], 0)
```

```DAX
Total Orders =
DISTINCTCOUNT(FactSales[Order ID])
```

```DAX
Total Quantity =
SUM(FactSales[Quantity])
```

```DAX
Returned Orders =
CALCULATE(
    DISTINCTCOUNT(FactSales[Order ID]),
    FactSales[Returned] = "Yes"
)
```

```DAX
Return Rate =
DIVIDE([Returned Orders], [Total Orders], 0)
```

These measures assume the Returns flag has been correctly merged into `FactSales` and uses the value `"Yes"` for returned orders.

## Data Quality and Analytical Considerations

- Repeated Order IDs in the sales table are not automatically duplicates; a single order may contain multiple product lines.
- The order identifier should be counted distinctly when measuring order volume.
- Profit margin should be calculated as total profit divided by total sales, not as the unweighted average of row-level margins.
- Return information should be joined at the correct grain to avoid multiplying sales or profit.
- Monthly targets should be sourced from an explicit target table or clearly documented assumptions.
- SQL, Python, and Power BI results should be compared using consistent filters, definitions, and aggregation levels.

## Business Questions

- Which categories and sub-categories generate the most sales and profit?
- Which sub-categories contribute negative profit?
- How do regional sales and margins compare?
- How does sales performance change month over month and year over year?
- Which customer segments contribute to sales and profitability?
- What proportion of distinct orders is marked as returned?
- Where should management investigate potential profitability improvements?

## Results and Business Recommendations

Add your validated findings here after running the final analyses.

Recommended format:

- **Finding:** [Insert a verified result and its comparison period.]
- **Business implication:** [Explain what the result suggests.]
- **Recommended action:** [Describe a follow-up supported by the available evidence.]

Avoid presenting illustrative dashboard figures as actual project results.

## Repository Structure

```text
excel/       Excel validation and analysis notes
mysql/       Database setup and analytical SQL
python/      Jupyter notebook and dependencies
powerbi/     PBIX report, DAX measures, and model notes
reports/     Project report and business insights
screenshots/ Power BI report screenshots
data/        Raw, processed, and output data documentation
```

## How to Reproduce the Project

1. Download the source dataset from the documented source.
2. Review the Excel data quality notes.
3. Create the MySQL database and import the source tables.
4. Execute the SQL scripts in numerical order.
5. Install the Python dependencies and run the notebook.
6. Open the Power BI file and verify data-source paths.
7. Refresh the model and validate core measures.
8. Publish to Power BI Service if access is available.
9. Compare the final outputs with the documented quality checks.

## Limitations

- Results depend on the specific version of the Sample Superstore dataset.
- Return analysis is limited by the available return records and their definitions.
- Sales targets are not assumed to exist in the source data.
- Any targets, forecasts, or scenarios added for demonstration should be labeled as illustrative.
- Published refresh behavior depends on the source location, credentials, gateway configuration, and licensing.

## Author

**[Your Name]**

Data Analytics Portfolio Project | Excel | MySQL | Python | Power BI

GitHub: [Insert GitHub profile URL]
