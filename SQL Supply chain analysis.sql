select top 5 *
from dbo.DataCoSupplyChainDataset;
select count(distinct[order_id]) as total_orders,
sum(sales) as Total_Sales,
sum([Order_Profit_Per_Order]) as Total_Profit,
count(distinct[Order_Customer_Id]) as Total_Customers,
sum([Order_Item_Quantity]) as Total_Units
from dbo.DataCoSupplyChainDataset;
select 
[delivery_status],
count(distinct[order_id]) as Total_orders
from dbo.DataCoSupplyChainDataset
group by Delivery_Status
order by Total_orders desc;
with order_risk as 
(select [order_id], max(cast([late_delivery_risk] as int)) as Late_risk
from dbo.DataCoSupplyChainDataset
group by Order_Id
)
select count(*) as Total_orders,
sum(case when Late_risk = 1 then 1 else 0 end) as at_risk_orders,
cast(100.0 * sum(case when Late_risk = 1 then 1 else 0 end) / nullif(count(*), 0)
as decimal(10, 2)
)
as Late_risk_percentage
from order_risk;
select table_schema, table_name
from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'Base Table';
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCoSupplyChainDataset'
ORDER BY ORDINAL_POSITION;
select 
    Shipping_Mode,
    count(distinct Order_Id) AS Total_Orders,
    round(avg(cast(Days_for_shipping_real as float)), 2)
        as Avg_Actual_Shipping_Days,
    round(avg(cast(Days_for_shipment_scheduled as float)), 2)
        as Avg_Scheduled_Shipping_Days,
    sum(Sales) as Total_Sales
from dbo.DataCoSupplyChainDataset
group by Shipping_Mode
order by Total_Orders desc;
select Order_Region,
count(distinct Order_Id) as Total_Orders,
sum(Sales) as Total_Sales, sum(Order_Profit_Per_Order) as Total_Profit
from dbo.DataCoSupplyChainDataset
group by Order_Region
order by Total_Sales desc;
select left(cast(order_date_DateOrders as varchar(50)), 7) as Order_Month,
    sum(Sales) as Monthly_Sales,
    count(distinct Order_Id)  Total_Orders
from dbo.DataCoSupplyChainDataset
group by left(cast(order_date_DateOrders as varchar(50)), 7)
order by Order_Month;
select Top 10 Category_Name,
sum(Sales) as Total_Sales, sum(Order_Profit_Per_Order) as Total_Profit,
sum(Order_Item_Quantity) as Units_Sold
from dbo.DataCoSupplyChainDataset
group by Category_Name
order by Total_Sales desc;
Select Top 10 Product_Name, sum(Sales) as Total_Sales, sum(Order_Item_Quantity) as Units_Sold
from dbo.DataCoSupplyChainDataset
group by Product_Name
order by Total_Sales desc;
select order_status, count(distinct order_id) as Total_Orders,
Sum(sales) as Total_sales
from dbo.DataCoSupplyChainDataset
group by Order_Status
order by Total_sales desc;
select Shipping_Mode,
round(avg(cast(Days_for_shipping_real as float)), 2) as Actual_Days,
round(avg(cast(Days_for_shipment_scheduled as float)), 2) as Scheduled_Days,
round(avg(cast(Days_for_shipping_real as float))
        - avg(cast(Days_for_shipment_scheduled as float)),
        2
    ) as Average_Day_Difference
from dbo.DataCoSupplyChainDataset
group by Shipping_Mode
order by Average_Day_Difference desc;
select market, count(distinct order_id) as Total_orders, 
sum(sales) as Total_Sales, sum(order_profit_per_order) as Total_profit
from dbo.DataCoSupplyChainDataset
group by Market
order by Total_Sales desc;
select Top 10 order_state, count(distinct order_id) as Total_Orders, 
SUM(cast(late_delivery_risk as int)) as At_Risk_Order_Items
from dbo.DataCoSupplyChainDataset
group by Order_State
order by At_Risk_Order_Items desc;
Select
    Count(*) as Total_Rows,
    sum(case when Latitude is null then 1 else 0 end) as Missing_Latitude,
     sum(case when Longitude is null then 1 else 0 end) as Missing_Longitude,
 sum(case when Sales is null then 1 else 0 end) as Missing_Sales,
    sum(case when Order_Id is null then 1 else 0 end) as Missing_Order_ID
from dbo.DataCoSupplyChainDataset;
select
    Customer_Segment,
    count(distinct Order_Customer_Id) as Total_Customers,
    count(distinct Order_Id) as Total_Orders,
    sum(Sales) as Total_Sales
from dbo.DataCoSupplyChainDataset
group by Customer_Segment
order by Total_Sales desc;
Select Department_Name,
sum(Sales) as Total_Sales,
sum(Order_Profit_Per_Order) as Total_Profit,
sum(Order_Item_Quantity) as Units_Sold
from dbo.DataCoSupplyChainDataset
group by Department_Name
order by Total_Profit desc;
Select Delivery_Status, 
count(distinct order_id) as Total_orders
from dbo.DataCoSupplyChainDataset
group by delivery_status
order by Total_orders desc;
select Top 10 order_Customer_id, count(distinct order_id) as Total_orders, 
sum(sales) as Total_sales
from dbo.DataCoSupplyChainDataset
group by Order_Customer_Id
order by Total_sales desc;
select Category_name, sum(sales) as Total_sales, 
sum(order_profit_per_order) as Total_profit,
ROUND(100.0 * sum(order_profit_per_order) / nullif(sum(sales), 0), 2) as Profit_Percentage
from dbo.DataCoSupplyChainDataset
group by Category_Name
order by Profit_Percentage desc;