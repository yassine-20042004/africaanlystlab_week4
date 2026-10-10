-- ==============================================================================
-- Project: FinTrust Digital Bank — Week 4 Final Analysis
-- Deliverable: FinTrust_Week4_SQL_Analysis.sql
-- Description: Refined SQL Queries with Advanced CTEs, Window Functions, and Risk Matrices
-- Compatible: PostgreSQL, MySQL 8.0+, DuckDB, SQLite (3.25+)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. Window Functions: Customer Transaction Velocity & Rolling Mean Deviation
-- Technique: CTE, Window Functions (AVG OVER, ROW_NUMBER OVER)
-- Business Value: Identifies transaction anomalies where an individual transaction 
-- exceeds 3x the customer's personal historical average transaction amount.
-- ------------------------------------------------------------------------------
WITH Customer_Baselines AS (
    SELECT 
        t.Transaction_ID,
        t.Customer_ID,
        c.Customer_Name,
        c.Customer_Segment,
        t.Transaction_DateTime,
        t.Amount_NGN,
        t.Risk_Review_Flag,
        AVG(t.Amount_NGN) OVER (PARTITION BY t.Customer_ID) AS Customer_Mean_Amount,
        ROW_NUMBER() OVER (PARTITION BY t.Customer_ID ORDER BY t.Transaction_DateTime DESC) AS Tx_Sequence
    FROM FinTrust_Transaction_Data t
    JOIN FinTrust_Customer_Data c ON t.Customer_ID = c.Customer_ID
)
SELECT 
    Transaction_ID,
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Amount_NGN,
    ROUND(Customer_Mean_Amount, 2) AS Customer_Avg_NGN,
    ROUND((Amount_NGN / NULLIF(Customer_Mean_Amount, 0)), 2) AS Multiplier_Over_Avg,
    Risk_Review_Flag
FROM Customer_Baselines
WHERE Amount_NGN > 2.5 * Customer_Mean_Amount
ORDER BY Multiplier_Over_Avg DESC
LIMIT 15;


-- ------------------------------------------------------------------------------
-- 2. CTE & Aggregations: High-Risk Channel & Modality Heatmap Matrix
-- Technique: CTE, Aggregations, CASE Statements, Group By
-- Business Value: Evaluates risk concentration across channel-modality pairs to pinpoint 
-- high-exposure operational channels (e.g. Mobile App + International Transfers).
-- ------------------------------------------------------------------------------
WITH Risk_Matrix AS (
    SELECT 
        Channel,
        Transaction_Type,
        International_Transaction,
        COUNT(*) AS Total_Volume,
        SUM(Amount_NGN) AS Total_Value_NGN,
        SUM(CASE WHEN Risk_Review_Flag = 'Yes' THEN 1 ELSE 0 END) AS Risk_Flags_Count,
        SUM(CASE WHEN Transaction_Status = 'Failed' THEN 1 ELSE 0 END) AS Failures_Count
    FROM FinTrust_Transaction_Data
    GROUP BY Channel, Transaction_Type, International_Transaction
)
SELECT 
    Channel,
    Transaction_Type,
    International_Transaction,
    Total_Volume,
    ROUND(Total_Value_NGN, 2) AS Total_Value_NGN,
    Risk_Flags_Count,
    ROUND(Risk_Flags_Count * 100.0 / Total_Volume, 2) AS Risk_Flag_Rate_Pct,
    ROUND(Failures_Count * 100.0 / Total_Volume, 2) AS Failure_Rate_Pct
FROM Risk_Matrix
WHERE Total_Volume >= 50
ORDER BY Risk_Flag_Rate_Pct DESC;


-- ------------------------------------------------------------------------------
-- 3. Window Function: Ranked Top Risk-Generating Customers by City
-- Technique: CTE, DENSE_RANK() OVER (PARTITION BY City ORDER BY ...), Aggregations
-- Business Value: Enables regional risk officers in Lagos, Abuja, and Port Harcourt 
-- to review top risk-concentrated customer accounts per jurisdiction.
-- ------------------------------------------------------------------------------
WITH Customer_Risk_Summary AS (
    SELECT 
        c.City,
        c.Customer_ID,
        c.Customer_Name,
        c.Customer_Segment,
        COUNT(t.Transaction_ID) AS Total_Txs,
        SUM(CASE WHEN t.Risk_Review_Flag = 'Yes' THEN 1 ELSE 0 END) AS Risk_Txs,
        SUM(t.Amount_NGN) AS Total_Volume_NGN
    FROM FinTrust_Customer_Data c
    JOIN FinTrust_Transaction_Data t ON c.Customer_ID = t.Customer_ID
    GROUP BY c.City, c.Customer_ID, c.Customer_Name, c.Customer_Segment
),
Ranked_Regional_Risk AS (
    SELECT 
        City,
        Customer_ID,
        Customer_Name,
        Customer_Segment,
        Total_Txs,
        Risk_Txs,
        ROUND(Risk_Txs * 100.0 / Total_Txs, 2) AS Risk_Pct,
        DENSE_RANK() OVER (PARTITION BY City ORDER BY Risk_Txs DESC, Total_Volume_NGN DESC) AS Regional_Risk_Rank
    FROM Customer_Risk_Summary
)
SELECT 
    City,
    Regional_Risk_Rank,
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Total_Txs,
    Risk_Txs,
    Risk_Pct
FROM Ranked_Regional_Risk
WHERE Regional_Risk_Rank <= 3
ORDER BY City, Regional_Risk_Rank;


-- ------------------------------------------------------------------------------
-- 4. Subquery: Customer Cohort Segmentation by Digital Engagement & Risk Ratio
-- Technique: Subquery, CASE Statements, Grouping
-- Business Value: Segmenting customers by engagement score and risk density reveals 
-- whether highly digital users experience lower operational risk or higher target review rates.
-- ------------------------------------------------------------------------------
SELECT 
    Engagement_Cohort,
    COUNT(Customer_ID) AS Total_Customers,
    ROUND(AVG(Total_Txs), 1) AS Avg_Txs_Per_Customer,
    ROUND(AVG(Risk_Flag_Rate_Pct), 2) AS Avg_Risk_Rate_Pct,
    ROUND(SUM(Total_Volume_NGN), 2) AS Total_Cohort_Volume_NGN
FROM (
    SELECT 
        c.Customer_ID,
        CASE 
            WHEN c.Digital_Engagement_Score >= 80 THEN 'Tier 1: High Digital (80-100)'
            WHEN c.Digital_Engagement_Score >= 50 THEN 'Tier 2: Medium Digital (50-79)'
            ELSE 'Tier 3: Low Digital (<50)'
        END AS Engagement_Cohort,
        COUNT(t.Transaction_ID) AS Total_Txs,
        SUM(CASE WHEN t.Risk_Review_Flag = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.Transaction_ID) AS Risk_Flag_Rate_Pct,
        SUM(t.Amount_NGN) AS Total_Volume_NGN
    FROM FinTrust_Customer_Data c
    JOIN FinTrust_Transaction_Data t ON c.Customer_ID = t.Customer_ID
    GROUP BY c.Customer_ID, c.Digital_Engagement_Score
) SubCohort
GROUP BY Engagement_Cohort
ORDER BY Engagement_Cohort;


-- ------------------------------------------------------------------------------
-- 5. Window Function: Cumulative Monthly Volume & Target Risk Trend Analysis
-- Technique: Date Extraction, SUM() OVER (ORDER BY Month), Aggregations
-- Business Value: Evaluates month-over-month growth of overall transaction flow 
-- vs. risk review flag growth to verify stability of automated risk volume.
-- ------------------------------------------------------------------------------
WITH Monthly_Aggregation AS (
    SELECT 
        SUBSTR(Transaction_DateTime, 1, 7) AS Year_Month,
        COUNT(*) AS Monthly_Tx_Volume,
        SUM(Amount_NGN) AS Monthly_Value_NGN,
        SUM(CASE WHEN Risk_Review_Flag = 'Yes' THEN 1 ELSE 0 END) AS Monthly_Risk_Txs
    FROM FinTrust_Transaction_Data
    GROUP BY SUBSTR(Transaction_DateTime, 1, 7)
)
SELECT 
    Year_Month,
    Monthly_Tx_Volume,
    ROUND(Monthly_Value_NGN, 2) AS Monthly_Value_NGN,
    Monthly_Risk_Txs,
    ROUND(Monthly_Risk_Txs * 100.0 / Monthly_Tx_Volume, 2) AS Risk_Rate_Pct,
    SUM(Monthly_Tx_Volume) OVER (ORDER BY Year_Month) AS Cumulative_Tx_Volume,
    ROUND(SUM(Monthly_Value_NGN) OVER (ORDER BY Year_Month), 2) AS Cumulative_Value_NGN
FROM Monthly_Aggregation
ORDER BY Year_Month;
