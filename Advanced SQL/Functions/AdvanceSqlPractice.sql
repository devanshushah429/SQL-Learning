-- Capital Gain/Loss
SELECT stock_name, Sum(case when operation = 'Buy' then (price * -1) else price end) as capital_gain_loss 
FROM STOCKS
GROUP BY stock_name