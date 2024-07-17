-- Recyclable and Low Fat Products
SELECT
    product_id
FROM
    Products
WHERE
    low_fats = 'Y'
    AND recyclable = 'Y'

-- Find Customer Referee
SELECT
    name
FROM
    Customer
WHERE 
    referee_id IS NULL
    OR referee_id != 2

-- Big Countries
SELECT
    name
    ,population
    ,area
FROM
    World
WHERE
    population >= 25000000
    OR area >= 3000000

-- Article Views I
SELECT DISTINCT author_id as id
FROM Views
WHERE viewer_id = author_id
ORDER BY author_id

-- Invalid Tweets
SELECT 
    tweet_id
FROM
    Tweets
WHERE
    LEN(content) > 15