create table Customers (
CustomerID int 
constraint pk_customers primary key not null,
FirstName nvarchar(50) not null,
MiddleName nvarchar(50) default ('N/A'),
LastName nvarchar(50) not null,
[Address] nvarchar(100) default ('N/A'),
Email nvarchar(100) 
constraint unique_email unique not null
)

create table CustomerPhones (
CustomerID int
constraint fk_CustomerPhones_Customers foreign key(CustomerID)
references Customers(CustomerID) not null,
PhoneNumber nvarchar(20) 
constraint unique_phone unique not null,
primary key(CustomerID,PhoneNumber)
)

create table Cars (
CarID int 
constraint pk_cars primary key not null,
PlateNumber nvarchar(50) 
constraint unique_plate_number unique not null,
BrandName nvarchar(50) not null,
[Model] nvarchar (50) default ('N/A'),
CustomerID int
constraint fk_cars_Customers foreign key(CustomerID) 
references Customers(CustomerID) not null
)

--drop table Cars
--drop table CustomerPhones
--drop table Customers
----use Car_WorkShop
