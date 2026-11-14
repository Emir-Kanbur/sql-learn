-- Bu kontroller yalnızca test için açılmış boş bir veritabanında çalıştırılır.
IF (SELECT COUNT(*) FROM dbo.Customers) <> 4
    OR (SELECT COUNT(*) FROM dbo.Products) <> 4
    OR (SELECT COUNT(*) FROM dbo.SalesOrders) <> 5
    OR (SELECT COUNT(*) FROM dbo.OrderItems) <> 7
    THROW 50002, N'Örnek kayıt sayıları beklenen değerlerden farklı.', 1;

DECLARE @OrderTotal decimal(38, 2);
SELECT @OrderTotal = SUM(i.Quantity * p.Price)
FROM dbo.OrderItems AS i
INNER JOIN dbo.Products AS p
    ON p.ProductId = i.ProductId
WHERE i.OrderId = 1001;

IF COALESCE(@OrderTotal, 0) <> 1598.90
    THROW 50003, N'1001 numaralı siparişin tutarı beklenen değerden farklı.', 1;
GO
