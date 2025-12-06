
VETTY SQL TEST — SOLUTIONS 

Assumptions:
- refund_item column actually represents refund_time (timestamp).
- NULL refund_time = no refund.
- gross_transaction_value stored as text ('$24'), so CAST/REPLACE will be used when needed

1. Count of purchases per month (excluding refunded)

SELECT
    DATE_FORMAT(purchase_time, '%Y-%m') AS month,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_item IS NULL       -- means not refunded
GROUP BY DATE_FORMAT(purchase_time, '%Y-%m')
ORDER BY month;

2. How many stores received at least 5 orders 
   in October 2020?

SELECT 
    store_id,
    COUNT(*) AS order_count
FROM transactions
WHERE refund_item IS NULL
  AND purchase_time >= '2020-10-01'
  AND purchase_time < '2020-11-01'
GROUP BY store_id
HAVING COUNT(*) >= 5;

3. For each store, shortest interval (minutes)
   from purchase_time to refund_time

SELECT 
    store_id,
    MIN(TIMESTAMPDIFF(MINUTE, purchase_time, refund_item)) AS shortest_interval_min
FROM transactions
WHERE refund_item IS NOT NULL
GROUP BY store_id;

4. Gross transaction value of every store’s first order

WITH first_order AS (
    SELECT 
        store_id,
        MIN(purchase_time) AS first_purchase
    FROM transactions
    GROUP BY store_id
)

SELECT 
    t.store_id,
    t.buyer_id,
    t.purchase_time,
    t.gross_transaction_value
FROM transactions t
JOIN first_order f
  ON t.store_id = f.store_id
 AND t.purchase_time = f.first_purchase;

5. Most popular item ordered on buyer’s first purchase

WITH first_purchase AS (
    SELECT 
        buyer_id,
        MIN(purchase_time) AS first_time
    FROM transactions
    GROUP BY buyer_id
)

SELECT 
    i.item_name,
    COUNT(*) AS ordered_count
FROM first_purchase fp
JOIN transactions t
    ON t.buyer_id = fp.buyer_id
   AND t.purchase_time = fp.first_time
JOIN items i
    ON i.item_id = t.item_id
GROUP BY i.item_name
ORDER BY ordered_count DESC
LIMIT 1;

6. Create a refund eligibility flag (within 72 hours)

SELECT
    buyer_id,
    purchase_time,
    refund_item AS refund_time,
    CASE
        WHEN refund_item IS NULL THEN 'Cannot Process'
        WHEN TIMESTAMPDIFF(HOUR, purchase_time, refund_item) <= 72
             THEN 'Process Refund'
        ELSE 'Cannot Process'
    END AS refund_flag
FROM transactions;

7. Rank transactions per buyer and return ONLY
   the second purchase per buyer (ignoring refunds)

WITH ranked AS (
    SELECT
        buyer_id,
        purchase_time,
        item_id,
        store_id,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS rn
    FROM transactions
    WHERE refund_item IS NULL
)

SELECT *
FROM ranked
WHERE rn = 2;

8. Find second transaction time per buyer
   WITHOUT using MIN/MAX

WITH order_list AS (
    SELECT
        buyer_id,
        purchase_time,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS rn
    FROM transactions
)

SELECT 
    buyer_id,
    purchase_time AS second_transaction_time
FROM order_list
WHERE rn = 2;

