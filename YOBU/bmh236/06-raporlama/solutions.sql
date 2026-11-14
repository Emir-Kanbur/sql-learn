SELECT Donem, COUNT(*) AS KayitAdedi, COUNT(Puan) AS PuanliAdet,
       COUNT(*) - COUNT(Puan) AS PuanBekleyenAdet
FROM bmh236.Kayit
GROUP BY Donem
ORDER BY Donem;

SELECT KatilimciId, AVG(CAST(Puan AS decimal(5, 2))) AS Ortalama
FROM bmh236.Kayit
GROUP BY KatilimciId
HAVING COUNT(*) > 1
ORDER BY KatilimciId;
