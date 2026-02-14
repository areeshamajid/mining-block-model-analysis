--Create table
DROP TABLE IF EXISTS mining_block_model;
CREATE TABLE mining_block_model (
  block_id VARCHAR(10) PRIMARY KEY ,
  x integer,
  y integer,
  z integer,
  rock_type text,
  ore_grade_pct numeric,
  tonnage numeric,
  ore_value_y_per_t numeric,
  mining_cost_y numeric,
  processing_cost_y numeric,
  waste_flag integer,
  profit_y numeric,
  target integer,
  business_category text
);

SELECT * FROM mining_block_model;

SELECT COUNT(*) FROM mining_block_model;

--Check mapping worked 
SELECT rock_type,
       business_category,
       COUNT(*) AS block_count
FROM mining_block_model
GROUP BY rock_type, business_category
ORDER BY rock_type;

-- Size of each business category 
SELECT business_category,
       COUNT(*) AS total_blocks
FROM mining_block_model
GROUP BY business_category;

-- Profit behaviour by category 
SELECT business_category,
       AVG(profit_y) AS avg_profit,
       SUM(profit_y) AS total_profit
FROM mining_block_model
GROUP BY business_category
ORDER BY avg_profit DESC;

--Profit by rock type 
SELECT rock_type,
       business_category,
       AVG(profit_y) AS avg_profit,
       SUM(profit_y) AS total_profit,
       COUNT(*)      AS block_count
FROM mining_block_model
GROUP BY rock_type, business_category
ORDER BY total_profit DESC;

--High-grade ore blocks
SELECT block_id,
       rock_type,
       business_category,
       ore_grade_pct,
       profit_y
FROM mining_block_model
WHERE business_category = 'Ore_Block'
  AND ore_grade_pct > 40   -- adjust threshold if needed
ORDER BY ore_grade_pct DESC
LIMIT 20;

--Top and bottom blocks (risk/opportunity)
-- Most profitable
SELECT block_id, rock_type, business_category, profit_y
FROM mining_block_model
ORDER BY profit_y DESC
LIMIT 10;

-- Most unprofitable
SELECT block_id, rock_type, business_category, profit_y
FROM mining_block_model
ORDER BY profit_y ASC
LIMIT 10;

-- Top 5 profitable hematite blocks 
SELECT block_id,
       rock_type,
       business_category,
       profit_y
FROM (
    SELECT block_id,
           rock_type,
           business_category,
           profit_y,
           ROW_NUMBER() OVER (
               PARTITION BY rock_type
               ORDER BY profit_y DESC
           ) AS rn
    FROM mining_block_model
) t
WHERE rock_type = 'Hematite'
  AND rn <= 5
ORDER BY profit_y DESC;

--Top 5 Magnetite blocks 
SELECT block_id, rock_type, business_category, profit_y
FROM mining_block_model
ORDER BY profit_y ASC
LIMIT 10;

-- Top 5 profitable hematite blocks 
SELECT block_id,
       rock_type,
       business_category,
       profit_y
FROM (
    SELECT block_id,
           rock_type,
           business_category,
           profit_y,
           ROW_NUMBER() OVER (
               PARTITION BY rock_type
               ORDER BY profit_y DESC
           ) AS rn
    FROM mining_block_model
) t
WHERE rock_type = 'Magnetite'
  AND rn <= 5
ORDER BY profit_y DESC;

-- Blocks count by rock type inside each business category
SELECT business_category,
       rock_type,
       COUNT(*) AS block_count
FROM mining_block_model
GROUP BY business_category, rock_type
ORDER BY business_category, block_count DESC;

--Profit vs ore grade for ore blocks 
SELECT
    CASE
        WHEN ore_grade_pct < 20 THEN 'Low_grade'
        WHEN ore_grade_pct < 40 THEN 'Medium_grade'
        ELSE 'High_grade'
    END AS grade_bucket,
    COUNT(*)          AS block_count,
    AVG(profit_y)     AS avg_profit,
    SUM(profit_y)     AS total_profit
FROM mining_block_model
WHERE business_category = 'Ore_Block'
GROUP BY grade_bucket
ORDER BY avg_profit DESC;

--Waste impact summary 
SELECT
    COUNT(*)              AS waste_blocks,
    SUM(profit_y)         AS total_waste_profit,
    AVG(profit_y)         AS avg_waste_profit
FROM mining_block_model
WHERE business_category = 'Waste_Material';


SELECT * FROM mining_block_model;




