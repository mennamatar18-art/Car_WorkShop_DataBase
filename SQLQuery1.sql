create table Custmers (
CustmerID int constraint pk_custmers primary key not null,
FirstName nvarchar(50) not null,
MiddleName nvarchar(50) default ('N/A'),
LastName nvarchar(50) not null,
[Address] nvarchar(100) default ('N/A'),
Email nvarchar(100) constraint unique_email unique not null
)

create table CustmerPhones (
CustmerID int
constraint fk_CustmerPhones_custmers foreign key(CustmerID)  references Custmers(CustmerID) not null,
PhoneNumber int constraint unique_phone unique not null,
primary key(CustmerID,PhoneNumber)
)

create table Cars (
CarID int constraint pk_cars primary key not null,
PlateNumber nvarchar(50) constraint unique_plate_number unique not null,
BrandName nvarchar(50) not null,
[Model] nvarchar (50) default ('N/A'),
CustmerID int
constraint fk_cars_custmers foreign key(CustmerID)  references Custmers(CustmerID) not null
)

--drop table Cars
--drop table CustmerPhones
--drop table Custmers
