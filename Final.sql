
CREATE DATABASE CarWorkshop

ON PRIMARY
(
    NAME = CarWorkshop_Primary,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\CarWorkshop.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),

FILEGROUP FG_CarWorkshop
(
    NAME = CarWorkshop_Secondary,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\CarWorkshop_Secondary.ndf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)

LOG ON
(
    NAME = CarWorkshop_Log1,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\CarWorkshop_Log1.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
),
(
    NAME = CarWorkshop_Log2,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\CarWorkshop_Log2.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
);


 


-- Car Workshop & Maintenance System

USE CarWorkshop;


-- 1. Customers

CREATE TABLE Customers
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    middle_name NVARCHAR(50) NOT NULL
        CONSTRAINT DF_Customers_MiddleName DEFAULT ('N/A'),
    last_name NVARCHAR(50) NOT NULL,
    [address] NVARCHAR(100) NOT NULL
        CONSTRAINT DF_Customers_Address DEFAULT ('N/A'),
    email NVARCHAR(50) UNIQUE,
);


-- 2. CustomerPhones

CREATE TABLE CustomerPhones
(
    customer_id INT NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,

    CONSTRAINT PK_CustomerPhones
        PRIMARY KEY (customer_id, phone_number),
    CONSTRAINT FK_CustomerPhones_Customers
        FOREIGN KEY (customer_id)
        REFERENCES Customers(id),
    CONSTRAINT UQ_CustomerPhones_PhoneNumber
        UNIQUE (phone_number)
);


-- 3. Cars

CREATE TABLE Cars
(
    id INT IDENTITY(1,1) PRIMARY KEY ,
    plate_number NVARCHAR(10) NOT NULL,
    brand_name NVARCHAR(20) NOT NULL,
    [model] NVARCHAR(40) ,
    customer_id INT NOT NULL,

    CONSTRAINT UQ_Cars_PlateNumber
        UNIQUE (plate_number),
    CONSTRAINT FK_Cars_Customers
        FOREIGN KEY (customer_id)
        REFERENCES Customers(id)
);


-- 4. Mechanics

CREATE TABLE Mechanics
(
    id INT IDENTITY(1,1) PRIMARY KEY ,
    name NVARCHAR(50) NOT NULL,
    specialization NVARCHAR(50) ,
    date_of_birth DATE ,
    date_of_join DATE NOT NULL
        CONSTRAINT DF_Mechanics_DateOfJoin DEFAULT GETDATE(),
    salary DECIMAL(8,2) NOT NULL,
    CONSTRAINT CK_Mechanics_Salary
        CHECK (salary > 0)
);


-- 5. Mechanic_Phones

CREATE TABLE MechanicPhones
(
    mechanic_id INT ,
    phone_number NVARCHAR(20) NOT NULL,

    CONSTRAINT PK_Mechanic_Phones
        PRIMARY KEY (mechanic_id, phone_number),

    CONSTRAINT FK_MechanicPhones_Mechanics
        FOREIGN KEY (mechanic_id)
        REFERENCES Mechanics(id),

    CONSTRAINT UQ_MechanicPhones_Phone
        UNIQUE (phone_number)
);


-- 6. Services

CREATE TABLE "Services" (
    id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(50) NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    estimated_duration INT ,

    CONSTRAINT CK_Services_Price
        CHECK (unit_price > 0),
    
    CONSTRAINT CK_Services_Duration
        CHECK (estimated_duration > 0)
);


--7. parts
CREATE TABLE Parts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    part_name NVARCHAR(50) NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    stock_quantity INT NOT NULL,

    CONSTRAINT CK_Parts_UnitPrice
        CHECK (unit_price > 0),
    CONSTRAINT CK_Parts_StockQuantity
        CHECK (stock_quantity >= 0)
);

-- 8. Invoice

CREATE TABLE Invoices
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    car_id INT NOT NULL,

    invoice_date DATETIME NOT NULL
        CONSTRAINT DF_Invoice_Date DEFAULT GETDATE(),

    CONSTRAINT FK_Invoice_Cars
        FOREIGN KEY (car_id)
        REFERENCES Cars(id)
);


-- 9. Invoice_Services

CREATE TABLE InvoiceServices
(
    invoice_id INT NOT NULL,
    service_id INT NOT NULL,
    mechanic_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,

    CONSTRAINT PK_Invoice_Services
        PRIMARY KEY (invoice_id, service_id),
    CONSTRAINT FK_InvoiceServices_Invoice
        FOREIGN KEY (invoice_id)
        REFERENCES Invoices(id),
    CONSTRAINT FK_InvoiceServices_Services
        FOREIGN KEY (service_id)
        REFERENCES Services(id),
    CONSTRAINT FK_InvoiceServices_Mechanics
        FOREIGN KEY (mechanic_id)
        REFERENCES Mechanics(id),

    CONSTRAINT CK_InvoiceServices_Quantity
        CHECK (quantity >= 1),
    CONSTRAINT CK_InvoiceServices_UnitPrice
        CHECK (unit_price > 0)
);


-- 10. Invoice_Parts

CREATE TABLE InvoiceParts
(
    invoice_id INT NOT NULL,
    part_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,

    CONSTRAINT PK_Invoice_Parts
        PRIMARY KEY (invoice_id, part_id),
    CONSTRAINT FK_InvoiceParts_Invoice
        FOREIGN KEY (invoice_id)
        REFERENCES Invoices(id),
    CONSTRAINT FK_InvoiceParts_Parts
        FOREIGN KEY (part_id)
        REFERENCES Parts(id),
    CONSTRAINT CK_InvoiceParts_Quantity
        CHECK (quantity >= 1),
    CONSTRAINT CK_InvoiceParts_UnitPrice
        CHECK (unit_price > 0)
);
