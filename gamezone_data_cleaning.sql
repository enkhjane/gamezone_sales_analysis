-- ================================
-- GameZone Orders - Analysis 
-- ================================
-- Yearly revenue trend
select
  purchase_year,
  round(sum(usd_price), 2) as total_revenue,
  count(order_id) as total_orders
from public.gamezone_orders
where purchase_year is not null
group by purchase_year
order by purchase_year;

-- Monthly revenue trend
select purchase_year, purchase_month,
round(sum(usd_price), 2) as total_revenue,
count(order_id) as total_orders
from public.gamezone_orders
where purchase_year is not null and purchase_month is not null
group by purchase_year, purchase_month
order by purchase_year, purchase_month;

-- Top Products by revenue
select product_name, count(order_id) as total_orders,
	round(sum(usd_price), 2) as total_revenue, 
	round(avg(usd_price), 2) as avg_order_value
from public.gamezone_orders
group by product_name
order by total_revenue DESC;

-- Refund Analysis
select product_name, count(order_id) as total_orders,
	count(refund_date) as total_refunds,
	round(count(refund_date)*100.0/count(order_id)) as refund_date_pct
from public.gamezone_orders
group by product_name
order by refund_date_pct DESC;

-- Marketing channel performance
select marketing_channel, 
	count(order_id) as total_orders,
	round(sum(usd_price),2) as total_revenue,
	round(avg(usd_price), 2) as avg_order_value,
	round(count(refund_date)*100.0/count(order_id), 2) as refund_rate_pct
from public.gamezone_orders
group by marketing_channel
order by total_revenue DESC;

--Platform comparison
select
  purchase_platform,
  count(order_id)                                        as total_orders,
  round(sum(usd_price), 2)                               as total_revenue,
  round(avg(usd_price), 2)                               as avg_order_value,
  round(count(refund_date) * 100.0 / count(order_id), 2) as refund_rate_pct
from public.gamezone_orders
group by purchase_platform
order by total_revenue desc;

-- Platform vs marketing channel breakdown
select
  purchase_platform,
  marketing_channel,
  count(order_id)          as total_orders,
  round(sum(usd_price), 2) as total_revenue
from public.gamezone_orders
group by purchase_platform, marketing_channel
order by purchase_platform, total_revenue desc;

-- Regional Analysis
select
  region,
  count(order_id)                                        as total_orders,
  round(sum(usd_price), 2)                               as total_revenue,
  round(avg(usd_price), 2)                               as avg_order_value,
  round(count(refund_date) * 100.0 / count(order_id), 2) as refund_rate_pct
from public.gamezone_orders
group by region
order by total_revenue desc;

