-- 1. En az iki müşterisi olan şehirler.
SELECT City, COUNT(*) AS CustomerCount
FROM dbo.Customers
GROUP BY City
HAVING COUNT(*) >= 2
ORDER BY CustomerCount DESC, City;

-- 2. Ürünlerin toplam satış adetleri.
SELECT p.ProductName, COALESCE(SUM(i.Quantity), 0) AS UnitsSold
FROM dbo.Products AS p
LEFT JOIN dbo.OrderItems AS i
    ON i.ProductId = p.ProductId
GROUP BY p.ProductId, p.ProductName
ORDER BY UnitsSold DESC, p.ProductId;

-- 3. 1000 TL'nin üzerindeki siparişler.
SELECT i.OrderId, SUM(i.Quantity * p.Price) AS OrderTotal
FROM dbo.OrderItems AS i
INNER JOIN dbo.Products AS p
    ON p.ProductId = i.ProductId
GROUP BY i.OrderId
HAVING SUM(i.Quantity * p.Price) > 1000
ORDER BY OrderTotal DESC, i.OrderId;
