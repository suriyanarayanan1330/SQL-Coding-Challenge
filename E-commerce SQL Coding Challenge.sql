create database Ecommerce;

use Ecommerce;


create table Customers (
    CustomerID int not null,
    FirstName varchar(225),
    LastName varchar(225),
    Email varchar(225),
    Address varchar(225),
    Password varchar(225),
    primary key(CustomerID)
);


create table Products(
   
   ProductID int not null,
   ProductName varchar(225),
   Price int ,
   Description varchar(225),
   StockQuantity int,
   primary key(ProductID)

);

create table Cart(
  
  CartID int not null,
  CustomerID int,
  ProductID int,
  Quantity int,
  primary key(CartID),
  constraint c_fk foreign key(CustomerID) references Customers(CustomerID) on delete cascade,
  constraint c_fk_p foreign key(ProductID) references Products(ProductID) on delete cascade

);

create table Orders(
   OrderID int,
   CustomerID int,
   OrderDate date,
   TotalPrice int,
   ShippingAddress varchar(225),
   primary key(OrderID),
   constraint o_fk_c foreign key(CustomerID) references  Customers(CustomerID) on delete cascade
   

);

create table OrderItems(
   
   OrderItemsID int,
   OrderID int,
   ProductID int,
   OrderItemsQuantity int,
   primary key(OrderItemsID),
   constraint oi_fk_o foreign key(OrderID) references Orders(OrderID) on delete cascade,
   constraint oi_fk_p foreign key(ProductID) references Products(ProductID) on delete cascade
   
);

insert into Products(ProductID, ProductName, Description, Price, StockQuantity) values
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

insert into Customers (CustomerID, FirstName, LastName, Email, Address, Password)
values
(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City', 'password1'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town', 'password2'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village', 'password3'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb', 'password4'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District', 'password5'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County', 'password6'),
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State', 'password7'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country', 'password8'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province', 'password9'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory', 'password10');

insert into Orders (OrderID, CustomerID, OrderDate, TotalPrice, ShippingAddress)
values
(1, 1, '2023-01-05', 1200.00, '123 Main St, City'),
(2, 2, '2023-02-10', 900.00, '456 Elm St, Town'),
(3, 3, '2023-03-15', 300.00, '789 Oak St, Village'),
(4, 4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
(5, 5, '2023-05-25', 1800.00, '234 Cedar St, District'),
(6, 6, '2023-06-30', 400.00, '567 Birch St, County'),
(7, 7, '2023-07-05', 700.00, '890 Maple St, State'),
(8, 8, '2023-08-10', 160.00, '321 Redwood St, Country'),
(9, 9, '2023-09-15', 140.00, '432 Spruce St, Province'),
(10, 10, '2023-10-20', 1400.00, '765 Fir St, Territory');

insert into OrderItems (OrderItemsID, OrderID, ProductID, OrderItemsQuantity)
values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 5, 2),
(5, 4, 4, 4),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 5, 2, 2),
(9, 6, 10, 2),
(10, 6, 9, 3);



insert into Cart (CartID, CustomerID, ProductID, Quantity)
values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);



-- 1.Query to update refeigirator product price to 800
select * from Products;

set sql_safe_updates = 0;
update Products set Price = 800 where ProductName = 'Refrigerator';
set sql_safe_updates = 1;

-- 2.Query to remove all the cart items for a specific customer
select * from Cart;

delete from Cart where CustomerID in (select CustomerID from Customers where FirstName = 'john');

-- 3.Query to retrive products priced below $100
select * from Products where Price < 100;

-- 4.Query to find the Products with the Stockquantity greater than 5
select * from Products where StockQuantity > 5;

-- 5.Query to retrive orders whose total amount is between $100 and $500
select * from Orders where TotalPrice between 100 and 500;

-- 6.Query to find the Products whose name end with 'r'
select * from Products where ProductName like '%r';

-- 6.Query to find the Products whose name end with 'r' using right() string function
select * from Products where right(ProductName,1) = 'r';

-- 7.Query to retrive cart items for customer 5

select * from Cart where CustomerID = 5;

select CartID,Cart.CustomerID, Customers.FirstName,Customers.LastName,Products.ProductName,Cart.ProductID,Quantity
from Customers
join 
Cart on Customers.CustomerID = Cart.CustomerID
join 
Products on Cart.ProductID = Products.ProductID
where Cart.CustomerID = 5;

-- 8.Query to find the customer who placed the order in 2023

select Orders.OrderID,Orders.CustomerID,Customers.FirstName,Customers.LastName 
from Orders
join
Customers
on Orders.CustomerID= Customers.CustomerID
where year(Orders.OrderDate) = 2023; 

-- 9.To find min stock quantity for each product category

alter table Products add Category varchar(100);
set sql_safe_updates = 0;

update Products set Category = 'Computers' where ProductName = 'Laptop';
update Products set Category = 'Mobiles' where ProductName = 'Smartphone';
update Products set Category = 'Tablets' where ProductName = 'Tablet';
update Products set Category = 'Audio' where ProductName = 'Headphones';
update Products set Category = 'Television' where ProductName = 'TV';
update Products set Category = 'Kitchen Appliances' where ProductName in ('Coffee Maker', 'Microwave Oven', 'Blender');
update Products set Category = 'Home Appliances' where ProductName in ('Refrigerator', 'Vacuum Cleaner');
set sql_safe_updates = 1;

select * from Products;
-- Query to min stock quantity for each product category
select ProductID , ProductName ,Category, Price,StockQuantity 
from Products p1 
where StockQuantity = (select min(StockQuantity) from Products p2 where p2.Category = p1.Category  );

-- 10.Query to Calculate total amount spend by each customer
select Customers.CustomerID, Customers.FirstName,Customers.LastName,sum(TotalPrice) as TotalAmountSpend
from Orders
left join Customers on Orders.CustomerID = Customers.CustomerID 
group by Orders.CustomerID ;

-- 11.Find the Avg order amount for each customer
select Customers.CustomerID, Customers.FirstName,Customers.LastName,avg(TotalPrice) as AvgOrderAmount
 from Orders
left join Customers on Orders.CustomerID = Customers.CustomerID 
group by Orders.CustomerID;

-- 12.No of Orders palced by Each customer
select Customers.CustomerID, Customers.FirstName,Customers.LastName,count(Orders.OrderID) as NoofOrders
 from Orders
left join Customers on Orders.CustomerID = Customers.CustomerID 
group by Orders.CustomerID;

-- 13.Maximum Order amount for each customer
select Customers.CustomerID, Customers.FirstName,Customers.LastName,max(TotalPrice) as MaxAmount
 from Orders
left join Customers on Orders.CustomerID = Customers.CustomerID 
group by Orders.CustomerID;

-- 14.Customers who placed order totaling more than $1000
select total.CustomerID, Customers.FirstName,Customers.LastName,Customers.Email,Customers.Address,total.TotalAmountSpend from Customers join
 (
 select CustomerID, sum(TotalPrice) as TotalAmountSpend
from Orders
group by CustomerID
) as total 
on Customers.CustomerID = total.CustomerID 
where total.TotalAmountSpend > 1000 ;

-- 15.Subquery to find Products not in the Cart
select * from Products where ProductID not in (select ProductID from Cart);


-- 16.Subquery to find Customers who have not placed orders
select * from Customers where CustomerID not in (select CustomerID from Orders);

-- 17.Subquery to calculate percentage of total revenue of the product

   select Products.ProductID,Products.ProductName , sum(OrderItems.OrderItemsQuantity * Products.Price) as renvenue_of_product ,
   (sum(OrderItems.OrderItemsQuantity * Products.Price)/ (select sum(TotalPrice) totalrenvenue from Orders))*100 
   as percentage_of_totalrevenue  
   from
   Products 
   join 
   OrderItems on Products.ProductID = OrderItems.ProductID
   group by OrderItems.ProductID 
   order by OrderItems.ProductID asc;
   

-- 18.subquey to find product with low stock
select * from Products p1 where StockQuantity = (select min(StockQuantity) from Products p2 );

-- 19.subquery to find customer who placed high value Orders
select total.CustomerID, Customers.FirstName,Customers.LastName,Customers.Email,Customers.Address,total.TotalAmountSpend from Customers join
 (
 select CustomerID, sum(TotalPrice) as TotalAmountSpend
from Orders
group by CustomerID
) as total 
on Customers.CustomerID = total.CustomerID 
order by total.TotalAmountSpend desc limit 1;
