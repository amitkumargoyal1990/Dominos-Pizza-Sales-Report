SELECT TOP (10) *
  FROM [Project].[dbo].[dominos_sales];

  use Project;

-- 1.Total Revenue
  Select Sum(total_price) as Total_Revenue
  from dominos_sales;

-- 2.Average Order Value
  Select sum(total_price)/count(distinct order_id) as Average_Order_Value
  from dominos_sales;

-- 3.Total Pizza Sold
  Select sum(quantity) as Total_Pizza_Sold
  from dominos_sales;

-- 4.Total Orders
  Select count(distinct order_id) as Total_Orders
  from dominos_sales;

-- 5. Average Pizzas Per Order
  Select Round(Sum(quantity)/count(distinct order_id),2) as Average_Pizza_Per_Order
  from dominos_sales;

-- Charts Requirement

-- 1.Daily Trend for Total Orders
-- DateTime() - Return a specified part of a date:
-- DW - day of the week

  Select DATENAME(DW,order_date) as order_day, Count(distinct order_id) as total_orders
  from dominos_sales
  group by DATENAME(DW,order_date);


-- 2.Monthly Trend for Total Orders
  Select DATENAME(MONTH,order_date) as order_month, Count(distinct order_id) as total_orders
  from dominos_sales
  group by DATENAME(Month,order_date);

-- 3.Percentage of sales by Pizza Category
  Select pizza_category, round(sum(total_price),2) as total_amount,
  round(sum(total_price),2) * 100 / (select round(sum(total_price),2) from dominos_sales)
  from dominos_sales
  group by pizza_category;

-- 4.Percentage of sales by Pizza Size
  Select pizza_size, round(sum(total_price),2) as total_amount,
  round(sum(total_price),2) * 100 / (select round(sum(total_price),2) from dominos_sales)
  from dominos_sales
  group by pizza_size;

-- 5.Total Pizzas Sold by Pizza Category
  Select pizza_category, count(quantity) as total_qnt
  from dominos_sales
  group by pizza_category;

-- 6.Top 5 Best Seller by Revenue, Total Qnantity and Total Orders

  -- a)Top 5 Best Seller by Revenue
    Select top 5 pizza_name, round(sum(total_price),2) as total_revenue
	from dominos_sales
	group by pizza_name
	order by round(sum(total_price),2) desc;

  -- b)Top 5 Best Seller by Total Qnantity
    Select top 5 pizza_name, count(quantity) as total_qnt
	from dominos_sales
	group by pizza_name
	order by count(quantity) desc;

  -- c)Top 5 Best Seller by Total Orders
    Select top 5 pizza_name, Count(distinct order_id) as total_orders
	from dominos_sales
	group by pizza_name
	order by Count(distinct order_id) desc;

-- 7.Bottom 5 Best Seller by Revenue, Total Qnantity and Total Orders

  -- a)Bottom 5 Best Seller by Revenue
    Select top 5 pizza_name, round(sum(total_price),2) as total_revenue
	from dominos_sales
	group by pizza_name
	order by round(sum(total_price),2);

  -- b)Bottom 5 Best Seller by Total Qnantity
    Select top 5 pizza_name, count(quantity) as total_qnt
	from dominos_sales
	group by pizza_name
	order by count(quantity);

  -- c)Bottom 5 Best Seller by Total Orders
    Select top 5 pizza_name, Count(distinct order_id) as total_orders
	from dominos_sales
	group by pizza_name
	order by Count(distinct order_id);
