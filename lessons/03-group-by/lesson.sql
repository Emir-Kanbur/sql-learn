-- Her şehir için müşteri sayısını hesapla.
SELECT City, COUNT(*) AS CustomerCount
FROM dbo.Customers
GROUP BY City
ORDER BY CustomerCount DESC, City;

-- Sipariş başına adetleri topla. HAVING, toplama sonucuna göre grupları süzer.
SELECT OrderId, SUM(Quantity) AS TotalQuantity
FROM dbo.OrderItems
GROUP BY OrderId
HAVING SUM(Quantity) >= 3
ORDER BY TotalQuantity DESC, OrderId;

-- Şubat ayı siparişlerini say. COUNT(OrderId), eşleşmeyen satırlardaki NULL değerleri atlar.
SELECT c.FullName, COUNT(o.OrderId) AS FebruaryOrders
FROM dbo.Customers AS c
LEFT JOIN dbo.SalesOrders AS o
    ON o.CustomerId = c.CustomerId
    AND o.OrderDate >= '20250201'
    AND o.OrderDate < '20250301'
GROUP BY c.CustomerId, c.FullName
ORDER BY FebruaryOrders DESC, c.CustomerId;
