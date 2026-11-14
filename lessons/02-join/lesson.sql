-- Siparişleri müşterileriyle eşleştir.
SELECT o.OrderId, o.OrderDate, c.FullName
FROM dbo.SalesOrders AS o
INNER JOIN dbo.Customers AS c
    ON c.CustomerId = o.CustomerId
ORDER BY o.OrderId;

-- Her müşteriyi göster. Şubat ayında sipariş vermeyenlerin sipariş alanları NULL olur.
-- Tarih koşulu ON içinde kalır ve eşleşmeyen müşteriler de sonuçta görünür.
SELECT c.FullName, o.OrderId, o.OrderDate
FROM dbo.Customers AS c
LEFT JOIN dbo.SalesOrders AS o
    ON o.CustomerId = c.CustomerId
    AND o.OrderDate >= '20250201'
    AND o.OrderDate < '20250301'
ORDER BY c.CustomerId, o.OrderId;

-- Sipariş satırlarını ürün bilgileriyle birleştir ve satırın tutarını hesapla.
SELECT i.OrderId, p.ProductName, i.Quantity, i.Quantity * p.Price AS LineTotal
FROM dbo.OrderItems AS i
INNER JOIN dbo.Products AS p
    ON p.ProductId = i.ProductId
ORDER BY i.OrderId, i.OrderItemId;
