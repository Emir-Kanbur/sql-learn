USE SqlLearn;
GO

-- Tablodaki tüm sütunları görmek için * kullanabilirsin.
SELECT *
FROM dbo.Customers;

-- Yalnızca ihtiyacın olan sütunları seçmek sonuçları daha okunaklı yapar.
SELECT FullName, City
FROM dbo.Customers;

-- WHERE satırları filtreler.
SELECT FullName, JoinedAt
FROM dbo.Customers
WHERE City = N'Ankara';

-- ORDER BY sonuçları sıralar; DESC azalan, ASC artan sıralamadır.
SELECT ProductName, Price
FROM dbo.Products
WHERE Price >= 500
ORDER BY Price DESC;

-- Bir aralıkta filtreleme.
SELECT OrderId, OrderDate
FROM dbo.SalesOrders
WHERE OrderDate >= '2025-02-01'
  AND OrderDate < '2025-03-01'
ORDER BY OrderDate ASC;
