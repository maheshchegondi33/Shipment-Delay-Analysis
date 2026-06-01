use mahi;
select * from train;
alter table  train rename to shipments;
select * from shipments;
-- Total shipments
select count(*) from shipments;
-- Delay percentage
select round(sum(case when Reached_on_Time_Y_N=1 then 1 else 0 end)/count(*)*100,2) as 
delay_percentage from shipments;
-- shipment mode performance
select Mode_of_Shipment,count(*) as total_orders,sum(case when Reached_on_Time_Y_N =1
then 1 else 0 end) as Delayed_orders from shipments group by Mode_of_Shipment;
-- Warehouse analysis
select Warehouse_block,count(*) as total_orders,sum(case when Reached_on_Time_Y_N =1
then 1 else 0 end) as Delayed_orders from shipments group by Warehouse_block 
order by Delayed_orders;
-- Average discound by delivery status
select Reached_on_Time_Y_N,round(avg(discount_offered),2) as avg_discount from shipments group by Reached_on_Time_Y_N;
-- Product importance analysis
select product_importance,count(*) as total_orders,sum(case when Reached_on_Time_Y_N=1 then 1 else 0 end) as delayed_orders
from shipments group by product_importance;
-- customer rating
select customer_rating,count(*) as total_orders from shipments group by customer_rating order by customer_rating;
-- top 5 discount offered order
select * from shipments order by discount_offered desc limit 5;
-- avg product_cost by shipment mode
select Mode_of_Shipment,round(avg(cost_of_the_product),2) as avg_product_cost from shipments group by Mode_of_Shipment;
-- weight analysis
select Reached_on_Time_Y_N,round(avg(Weight_in_gms),2) as avg_weight from shipments group by Reached_on_Time_Y_N; -- higher weight having more delay
-- Delay rate by warehouse
select Warehouse_block,round(sum(case when Reached_on_Time_Y_N=1 then 1 else 0 end)/count(*)*100,2) as Delay_rate 
from shipments group by Warehouse_block order by Delay_rate desc;
-- Rank warehouses by delay count:
SELECT
Warehouse_block,
COUNT(*) AS Delayed_Orders,
RANK() OVER (ORDER BY COUNT(*) DESC) AS Warehouse_Rank
FROM shipments WHERE Reached_on_Time_Y_N = 1 GROUP BY Warehouse_block;



