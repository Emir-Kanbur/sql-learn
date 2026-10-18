IF OBJECT_ID(N'dbo.Customers', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Customers
    (
        CustomerId int NOT NULL PRIMARY KEY,
        FullName nvarchar(100) NOT NULL,
        City nvarchar(100) NOT NULL,
        JoinedAt date NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Products', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Products
    (
        ProductId int NOT NULL PRIMARY KEY,
        ProductName nvarchar(100) NOT NULL,
        Price decimal(10, 2) NOT NULL CHECK (Price >= 0)
    );
END;
GO

IF OBJECT_ID(N'dbo.SalesOrders', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.SalesOrders
    (
        OrderId int NOT NULL PRIMARY KEY,
        CustomerId int NOT NULL,
        OrderDate date NOT NULL,
        CONSTRAINT FK_SalesOrders_Customers
            FOREIGN KEY (CustomerId) REFERENCES dbo.Customers (CustomerId)
    );
END;
GO

IF OBJECT_ID(N'dbo.OrderItems', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.OrderItems
    (
        OrderItemId int NOT NULL PRIMARY KEY,
        OrderId int NOT NULL,
        ProductId int NOT NULL,
        Quantity int NOT NULL CHECK (Quantity > 0),
        CONSTRAINT FK_OrderItems_SalesOrders
            FOREIGN KEY (OrderId) REFERENCES dbo.SalesOrders (OrderId),
        CONSTRAINT FK_OrderItems_Products
            FOREIGN KEY (ProductId) REFERENCES dbo.Products (ProductId)
    );
END;
GO

INSERT INTO dbo.Customers (CustomerId, FullName, City, JoinedAt)
SELECT sample.CustomerId, sample.FullName, sample.City, sample.JoinedAt
FROM (VALUES
    (1, N'Aylin Yılmaz', N'İstanbul', CONVERT(date, '2024-01-15')),
    (2, N'Bora Demir', N'Ankara', CONVERT(date, '2024-02-20')),
    (3, N'Cem Kaya', N'İzmir', CONVERT(date, '2024-03-05')),
    (4, N'Duru Şahin', N'Ankara', CONVERT(date, '2024-04-12'))
) AS sample (CustomerId, FullName, City, JoinedAt)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Customers AS existing
    WHERE existing.CustomerId = sample.CustomerId
);
GO

INSERT INTO dbo.Products (ProductId, ProductName, Price)
SELECT sample.ProductId, sample.ProductName, sample.Price
FROM (VALUES
    (101, N'Klavye', CONVERT(decimal(10, 2), 899.90)),
    (102, N'Fare', CONVERT(decimal(10, 2), 349.50)),
    (103, N'Monitör', CONVERT(decimal(10, 2), 5299.00)),
    (104, N'USB çoklayıcı', CONVERT(decimal(10, 2), 599.00))
) AS sample (ProductId, ProductName, Price)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Products AS existing
    WHERE existing.ProductId = sample.ProductId
);
GO

INSERT INTO dbo.SalesOrders (OrderId, CustomerId, OrderDate)
SELECT sample.OrderId, sample.CustomerId, sample.OrderDate
FROM (VALUES
    (1001, 1, CONVERT(date, '2025-01-10')),
    (1002, 2, CONVERT(date, '2025-01-12')),
    (1003, 1, CONVERT(date, '2025-02-03')),
    (1004, 3, CONVERT(date, '2025-02-18')),
    (1005, 4, CONVERT(date, '2025-03-01'))
) AS sample (OrderId, CustomerId, OrderDate)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.SalesOrders AS existing
    WHERE existing.OrderId = sample.OrderId
);
GO

INSERT INTO dbo.OrderItems (OrderItemId, OrderId, ProductId, Quantity)
SELECT sample.OrderItemId, sample.OrderId, sample.ProductId, sample.Quantity
FROM (VALUES
    (1, 1001, 101, 1),
    (2, 1001, 102, 2),
    (3, 1002, 103, 1),
    (4, 1003, 104, 1),
    (5, 1003, 102, 1),
    (6, 1004, 101, 2),
    (7, 1005, 104, 3)
) AS sample (OrderItemId, OrderId, ProductId, Quantity)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.OrderItems AS existing
    WHERE existing.OrderItemId = sample.OrderItemId
);
GO
