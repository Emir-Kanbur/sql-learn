-- 1. Ankara'daki müşterilerin siparişleri.
SELECT o.OrderId, c.FullName, o.OrderDate
FROM dbo.Customers AS c
INNER JOIN dbo.SalesOrders AS o
    ON o.CustomerId = c.CustomerId
WHERE c.City = N'Ankara'
ORDER BY o.OrderId;

-- 2. Her müşteri ve varsa Ocak 2025 siparişleri.
SELECT c.FullName, o.OrderId
FROM dbo.Customers AS c
LEFT JOIN dbo.SalesOrders AS o
    ON o.CustomerId = c.CustomerId
    AND o.OrderDate >= '20250101'
    AND o.OrderDate < '20250201'
ORDER BY c.CustomerId, o.OrderId;

-- 3. 1001 numaralı siparişin satırları.
SELECT p.ProductName, i.Quantity, i.Quantity * p.Price AS LineTotal
FROM dbo.OrderItems AS i
INNER JOIN dbo.Products AS p
    ON p.ProductId = i.ProductId
WHERE i.OrderId = 1001
ORDER BY i.OrderItemId;
