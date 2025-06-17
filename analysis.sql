-- ========================
-- RFM SEGMENTATION
-- ========================
--tag:rfm_query
WITH rfm_metrics AS (
  SELECT
    customer_id,
    MAX(order_date) AS last_order_date,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary,
    DATEDIFF('day', MAX(order_date::DATE), DATE '2025-05-06') AS recency
  FROM e_commerce_transactions
  GROUP BY customer_id
),
rfm_scores AS (
  SELECT *,
    NTILE(5) OVER (ORDER BY recency) AS r_score,
    NTILE(5) OVER (ORDER BY frequency) AS f_score,
    NTILE(5) OVER (ORDER BY monetary) AS m_score
  FROM rfm_metrics
),
rfm_segments AS (
  SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    CASE
      WHEN r_score <= 2 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
      WHEN r_score <= 2 AND f_score >= 3 THEN 'Loyal Customers'
      WHEN r_score <= 3 AND f_score >= 2 AND m_score >= 2 THEN 'Potential Loyalists'
      WHEN r_score >= 4 AND f_score >= 3 THEN 'At Risk'
      WHEN r_score >= 4 AND f_score <= 2 AND m_score >= 3 THEN 'Cannot Lose Them'
      WHEN r_score = 5 AND f_score <= 2 AND m_score <= 2 THEN 'Lost Customers'
      WHEN r_score BETWEEN 3 AND 4 AND f_score BETWEEN 2 AND 3 THEN 'Need Attention'
      ELSE 'Others'
    END AS customer_segment
  FROM rfm_scores
)
SELECT *
FROM rfm_segments
ORDER BY customer_id;


-- ========================
-- ANOMALY DETECTION
-- ========================
--tag:anomaly_query
WITH p99 AS (
  SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY payment_value) AS val
  FROM e_commerce_transactions
)
SELECT
  order_id,
  customer_id,
  payment_value,
  decoy_flag,
  decoy_noise,
  CASE
    WHEN decoy_noise > 500 OR decoy_noise < -500 THEN 'Anomaly_Noise'
    WHEN decoy_flag NOT IN ('A', 'B', 'C', 'D') THEN 'Anomaly_Flag'
    WHEN payment_value > (SELECT val FROM p99) THEN 'Anomaly_Payment'
    ELSE 'Normal'
  END AS anomaly_type,
  CASE
    WHEN decoy_noise > 500 OR decoy_noise < -500 THEN 'Noise out of range'
    WHEN decoy_flag NOT IN ('A', 'B', 'C', 'D') THEN 'Invalid flag'
    WHEN payment_value > (SELECT val FROM p99) THEN 'Outlier payment value (> P99)'
    ELSE 'No anomaly'
  END AS anomaly_reason
FROM e_commerce_transactions
WHERE
  decoy_noise > 500 OR decoy_noise < -500
  OR decoy_flag NOT IN ('A', 'B', 'C', 'D')
  OR payment_value > (SELECT val FROM p99)
ORDER BY decoy_noise DESC;


-- ========================
-- REPEAT PURCHASE ANALYSIS
-- ========================
--tag:repeat_query
WITH monthly_customers AS (
  SELECT
    DATE_TRUNC('month', order_date::DATE) as month,
    customer_id,
    COUNT(order_id) as orders_count
  FROM e_commerce_transactions
  GROUP BY DATE_TRUNC('month', order_date::DATE), customer_id
)
SELECT
  month,
  COUNT(DISTINCT customer_id) as total_customers,
  COUNT(DISTINCT CASE WHEN orders_count > 1 THEN customer_id END) as repeat_customers,
  ROUND(COUNT(DISTINCT CASE WHEN orders_count > 1 THEN customer_id END) * 100.0 / COUNT(DISTINCT customer_id), 2) as repeat_rate_percent
FROM monthly_customers
GROUP BY month
ORDER BY month;
