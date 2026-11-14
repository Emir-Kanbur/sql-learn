DECLARE @BolumId int = 1;

SELECT DersKodu, DersAdi
FROM bmh236.Ders
WHERE BolumId = @BolumId
ORDER BY DersKodu;

SELECT d.DersId, d.DersKodu, COUNT(r.DersId) AS KayitAdedi
FROM bmh236.Ders AS d
LEFT JOIN bmh236.Kayit AS r ON r.DersId = d.DersId
GROUP BY d.DersId, d.DersKodu
ORDER BY d.DersId;
