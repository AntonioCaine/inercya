--1.	Obtener la lista de los productos no descatalogados incluyendo el nombre de la categoría ordenado por nombre de producto.

select ProductName, CategoryName from Products, Categories				--sin join
where Discontinued = 0 and Products.CategoryID = Categories.CategoryID
order by ProductName;

select ProductName, CategoryName from Products							--con join
inner join Categories
on Products.CategoryID = Categories.CategoryID
where Discontinued = 0
order by ProductName;

--2.	Mostrar el nombre de los clientes de  Nancy Davolio.

select ContactName from Customers, Employees, Orders					--sin join
where	Employees.FirstName = 'Nancy' AND 
	Employees.LastName = 'Davolio' AND 
	Employees.EmployeeID = Orders.EmployeeID AND 
	Orders.CustomerID = Customers.CustomerID;

select ContactName from Customers										--con join
inner join Orders on Orders.CustomerID = Customers.CustomerID
inner join Employees on Employees.EmployeeID = Orders.EmployeeID
where Employees.FirstName = 'Nancy' AND 
	Employees.LastName = 'Davolio';

--3.	Mostrar el total facturado por año del empleado Steven Buchanan.

select YEAR(Orders.OrderDate), sum((UnitPrice*Quantity)*(1-Discount)) from Orders
inner join Employees on Employees.EmployeeID = Orders.EmployeeID
inner join [Order Details] on [Order Details].OrderID = Orders.OrderID
where Employees.FirstName = 'Steven' AND Employees.LastName = 'Buchanan'
group by YEAR(Orders.OrderDate);

--4.	Mostrar el nombre de los empleados que dependan directa o indirectamente de Andrew Fuller.

WITH reporting AS (
	select FirstName, LastName, EmployeeID, ReportsTo from Employees
	where ReportsTo = (select EmployeeID from Employees
						where FirstName = 'Andrew' AND LastName = 'Fuller')
	UNION ALL
	select e.FirstName, e.LastName, e.EmployeeID, e.ReportsTo from Employees e
	)
select distinct * from reporting
where ReportsTo IS NOT null
order by EmployeeID;
