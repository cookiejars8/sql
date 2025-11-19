/* Section 2: Question 1: SELECT */
SELECT * FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

/* Section 2: Question 2: WHERE */
SELECT * FROM customer_purchases
WHERE product_id IN (4, 9);

SELECT 
    *,
    (quantity * cost_to_customer_per_qty) AS price
FROM customer_purchases
WHERE customer_id BETWEEN 8 AND 10;

/* Section 2: Question 3: CASE */
SELECT 
    product_id,
    product_name,
    CASE 
        WHEN product_qty_type = 'unit' THEN 'unit'
        ELSE 'bulk'
    END AS prod_qty_type_condensed,
    CASE
        WHEN LOWER(product_name) LIKE '%pepper%' THEN 1
        ELSE 0
    END AS pepper_flag
FROM product;

/* Section 2: Question 4: JOIN */
SELECT *
FROM vendor v
INNER JOIN vendor_booth_assignments vba
    ON v.vendor_id = vba.vendor_id
ORDER BY v.vendor_name, vba.market_date;

/* Section 3: Question 1: AGGREGATE */
SELECT 
    vendor_id,
    COUNT(*) AS booth_rental_count
FROM vendor_booth_assignments
GROUP BY vendor_id;

SELECT 
    c.customer_id,
    c.customer_first_name,
    c.customer_last_name,
    SUM(cp.quantity * cp.cost_to_customer_per_qty) AS total_spent
FROM customer c
INNER JOIN customer_purchases cp
    ON c.customer_id = cp.customer_id
GROUP BY 
    c.customer_id,
    c.customer_first_name,
    c.customer_last_name
HAVING 
    SUM(cp.quantity * cp.cost_to_customer_per_qty) > 2000
ORDER BY 
    c.customer_last_name,
    c.customer_first_name;


/* Section 3: Question 2: TEMP */
CREATE TABLE temp.new_vendor AS
SELECT * FROM vendor;

INSERT INTO temp.new_vendor (
    vendor_id,
    vendor_name,
    vendor_type,
    vendor_owner_first_name,
    vendor_owner_last_name
)
VALUES (
    10,
    'Thomass Superfood Store',
    'Fresh Focused',
    'Thomas',
	'Rosenthal'
);ggit

/* Section 3: Question 3: DATE */
SELECT
    customer_id,
    STRFTIME('%m', market_date) AS purchase_month,
    STRFTIME('%Y', market_date) AS purchase_year
FROM customer_purchases;

SELECT
    customer_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE STRFTIME('%Y', market_date) = '2022'
  AND STRFTIME('%m', market_date) = '04'
GROUP BY customer_id;

