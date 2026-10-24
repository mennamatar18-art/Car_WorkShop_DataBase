CREATE TABLE Services (
    id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    estimated_duration INT NOT NULL,

    CONSTRAINT CK_Services_Price
        CHECK (price >= 0),

    CONSTRAINT CK_Services_Duration
        CHECK (estimated_duration > 0)
);



CREATE TABLE Parts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    part_name NVARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,

    CONSTRAINT CK_Parts_UnitPrice
        CHECK (unit_price >= 0),

    CONSTRAINT CK_Parts_StockQuantity
        CHECK (stock_quantity >= 0)
);
