USE SqlLearn;
GO

-- 1. Tüm ürün adlarını ve fiyatlarını listele.
SELECT ProductName, Price
FROM dbo.Products;

-- 2. Ankara'da yaşayan müşterilerin adlarını listele.
SELECT FullName
FROM dbo.Customers
WHERE City = N'Ankara';

-- 3. Fiyatı 500 ile 1000 (dahil) arasında olan ürünleri, pahalıdan ucuza sırala.
SELECT ProductName, Price
FROM dbo.Products
WHERE Price BETWEEN 500 AND 1000
ORDER BY Price DESC;

-- 4. 2025 Şubat ayında verilen siparişlerin numarasını ve tarihini listele.
SELECT OrderId, OrderDate
FROM dbo.SalesOrders
WHERE OrderDate >= '2025-02-01'
  AND OrderDate < '2025-03-01'
ORDER BY OrderDate;

-- 5. En yeni katılan iki müşteriyi listele.
SELECT TOP (2) FullName, JoinedAt
FROM dbo.Customers
ORDER BY JoinedAt DESC;
