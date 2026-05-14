create database customer_data_analysis;
use customer_data_analysis;

show tables;

-- Q1 Retrive customer details along with agent's name who helped them,showing total outstanding amount.
select c.* , a.agent_name
from customer c 
join agents a 
on c.agent_code = a.agent_code;
#OR
select a.agent_name, sum(c.outstanding_amt) as total_outstanding 
from customer c 
join agents a 
on c.agent_code = a.agent_code
group by a.agent_name;

-- Q.2.Find the agents whose total order amount exceeds 10,000.
select a.agent_code, a.agent_name, sum(o.ord_amount) as total_order
from agents a
join orders o
on a.agent_code = o.agent_code
group by a.agent_code, a.agent_name
having sum(o.ord_amount) > 10000; 


-- Q.3.	Create a view to list all orders along with customer names and their respective agent's names.
create view order_view as
select o.*, c.cust_name, a.agent_name
from orders o 
join agents a
on o.agent_code = a.agent_code
join customer c
on o.cust_code=c.cust_code
;
select * from order_view;

-- Q.4.	Find all orders placed by customers who reside in New York.
select o.ord_num, o.ord_amount, o.ord_description, c.cust_code, c.cust_name, c.cust_city
from orders o
join customer c
on o.cust_code = c.cust_code
where cust_city = 'New York';

-- Q.5.	Find the total number of orders handled by each agent.
select a.agent_code, count(o.ord_num) as Number_of_Orders
from orders o
join agents a
on o.agent_code=a.agent_code
group by a.agent_code;

-- Q.6.	Get the list of customers who placed an order with an advance 
-- amount greater than or equal to 50% of the order amount.
select c.cust_code,c.cust_name, o.advance_amount,o.ord_amount
from customer c
join orders o
on c.cust_code = o.cust_code
where o.advance_amount >= 0.5 * o.ord_amount;

-- Q.7.	Find the number of customers in each city and the total outstanding amount for each city.
select c.cust_city, count(c.cust_code) as Total_Customers, 
sum(c.outstanding_amt) as Total_Outstanding_Amount
from customer c group by c.cust_city;

-- Q.8.	List all customers along with their orders, including customers who have not placed any orders
select c.cust_code, c.cust_name, o.ord_num, o.ord_description
from customer c
left join orders o
on c.cust_code = o.cust_code;

-- Q.9.	Find the customer who placed the highest order amount using a subquery.
select c.cust_code, c.cust_name, o.ord_amount
from customer c
join orders o
on c.cust_code = o.cust_code
where o.ORD_AMOUNT = (select max(ord_amount) from orders);

-- Q.10.	Find the total order amount for customers who have placed more than 2 orders using a subquery.
select c.cust_code, c.cust_name, sum(o.ord_amount) as Total_Order_Amount
from customer c
join orders o
on c.cust_code = o.cust_code
where c.cust_code in (
	select cust_code
    from orders
    group by cust_code
    having count(*) > 2
    )
group by c.cust_code, c.cust_name;

-- Q.11.	List the orders placed in the month of May 2008
select c.cust_code, c.cust_name, o.ord_num, o.ord_amount, o.ord_date
from customer c
join orders o
on c.cust_code = o.cust_code
where ord_date between '2008-05-01' and '2008-05-31';
#OR
select * from ordeers 
where month(ord_date) = 5
and year(ord_date) = 2008;

-- Q.12.	List orders where the amount is greater than 1000 or the order date is before '2008-12-31'.
select c.cust_code, c.cust_name, o.ord_num, o.ord_amount, o.ord_date
from customer c
join orders o
on c.cust_code = o.cust_code
where ord_amount > 1000 
or ord_date < '2008-12-31';

-- Q.13.	Find all orders placed by customers in 'New York' 
-- or whose order amount is greater than 5000.
select c.cust_code, c.cust_name, c.cust_city, o.ord_num, o.ord_amount
from customer c
join orders o
on c.cust_code = o.cust_code
where c.cust_city = 'New York'
or ord_amount > 5000;

-- Q.14.	Find the agents who have handled orders for more than 3 distinct customers.
select a.agent_code, a.agent_name, count(distinct c.cust_code)
from agents a
join customer c
on a.agent_code = c.agent_code
group by a.agent_code,a.agent_name
having count(distinct c.cust_code) > 3;

-- Q.15.	Find customers who have made at least one payment but still have an outstanding 
#amount greater than 7000.
select cust_code, cust_name, outstanding_amt
from customer 
where payment_amt > 0
and outstanding_amt > 7000;

















