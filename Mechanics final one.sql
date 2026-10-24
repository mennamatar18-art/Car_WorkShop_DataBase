-- Mechanics table: one row for each mechanic
CREATE TABLE Mechanics (
    id INT IDENTITY(1,1),             -- IDENTITY: SQL Server numbers it automatically (1, 2, 3...)
    name NVARCHAR(100) NOT NULL,      -- NOT NULL: this value is required
    specialization NVARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    date_of_join DATE NOT NULL
        CONSTRAINT DF_Mechanics_DateOfJoin DEFAULT GETDATE(),  -- DEFAULT: uses today's date if we don't give one
    salary DECIMAL(10,2) NOT NULL,    -- DECIMAL(10,2): up to 10 digits, 2 after the point

    -- PRIMARY KEY: each id is unique and identifies one mechanic
    CONSTRAINT PK_Mechanics PRIMARY KEY (id),

    -- CHECK: the salary must be greater than 0
    CONSTRAINT CK_Mechanics_Salary CHECK (salary > 0)
);

-- Mechanic_Phones table: one mechanic can have many phone numbers (one-to-many)
-- It must be created AFTER Mechanics because it refers to it
CREATE TABLE Mechanic_Phones (
    mechanic_id INT NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,

    -- Composite PRIMARY KEY: the pair (mechanic_id + phone_number) must not repeat
    CONSTRAINT PK_Mechanic_Phones PRIMARY KEY (mechanic_id, phone_number),

    -- FOREIGN KEY: mechanic_id must already exist in Mechanics(id)
    CONSTRAINT FK_MechanicPhones_Mechanics FOREIGN KEY (mechanic_id)
        REFERENCES Mechanics(id),

    -- UNIQUE: the same phone number cannot be saved twice
    CONSTRAINT UQ_MechanicPhones_Phone UNIQUE (phone_number)
);
