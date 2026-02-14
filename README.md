# Mining Block Model – Ore vs Waste Profitability (PostgreSQL & Python)

**Author:** Areesha Majid

This project uses a toy iron‑ore block model to turn raw geological data into simple business insights using Python, PostgreSQL, and SQL. It focuses on mapping technical rock types into business categories (ore vs waste), cleaning the data, and analysing which blocks create or destroy value.

## 1. Project Overview

- **Goal:** Understand which parts of the block model make money (ore) and which lose money (waste), in a way that is easy for business stakeholders to read.
- **Data:** Single CSV file of block‑level data, including rock type, ore grade, tonnage, costs, and profit.
- **Tools:**
  - Python (Google Colab) for cleaning and outlier removal.
  - PostgreSQL for loading the cleaned data and running analysis queries.
  - pgAdmin (or any SQL client) for running the SQL file and viewing results.

## 2. Files in this Repository

- `README.md` – Project overview and how to run things.
- `mining_cleaned.csv` – Cleaned block model used in the database.
- `sql.sql` – SQL script with table creation and analysis queries.
- `mapping.docx` – Screenshots and SQL outputs used in the write‑up.
- Colab notebook `.ipynb` – Python cleaning and EDA, when you add it.

## 3. Data Cleaning (Python / Colab)

Key steps in the notebook:

- Load the raw block‑level CSV into a pandas DataFrame.
- Create a **`business_category`** field by mapping:
  - Hematite, Magnetite → `Ore_Block`
  - Waste → `Waste_Material`
- Remove extreme profit outliers using the IQR rule, keeping realistic positive and negative profits.
- Export the cleaned dataset as `mining_cleaned.csv` for use in PostgreSQL.

## 4. SQL Analysis (PostgreSQL)

All queries are in `sql.sql`, grouped as:

1. **Loading the Cleaned Data**
   - Create `mining_block_model` table and load `mining_cleaned.csv`.
2. **QA Checks (Counts and Mapping)**
   - Check rock type → `business_category` mapping and block counts by category and rock type.
3. **Profitability by Category and Rock Type**
   - Compare average and total profit for `Ore_Block` vs `Waste_Material` and for each rock type.
4. **Key Block‑Level Insights**
   - Top/bottom profit blocks, high‑grade ore blocks, and top 5 profitable blocks per rock type using window functions.

## 5.Project Files
- `mining_block_model_cleaning.ipynb` – Python / Colab notebook for data cleaning, outlier removal, and export of the cleaned CSV.
- `mining_cleaned.csv` – Cleaned block model dataset used for SQL analysis.
- `sql.sql` – PostgreSQL script: table creation, QA checks, profitability analysis, and block‑level insight queries.
- `report.docx` – Word report of queries and a detailed narrative of the analysis.
- `README.md` – Project overview, how to run, and main findings.
Put this just after you
## 6. How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/areeshamajid/mining-block-model-analysis.git
   cd mining-block-model-analysis

   2. **Set up PostgreSQL**
   - Create a database, for example `mining_block_model_db`.
   - Open your SQL client (pgAdmin, DBeaver, etc.).
   - Run `sql.sql`:
     - Create the `mining_block_model` table.
     - Load `mining_cleaned.csv` into the table (using COPY or your client’s import wizard).
     - Execute the analysis queries.

3. **Open the Python notebook**
   - Open `mining_block_model_cleaning.ipynb` in Colab or Jupyter to see the data‑cleaning and outlier‑removal steps.

