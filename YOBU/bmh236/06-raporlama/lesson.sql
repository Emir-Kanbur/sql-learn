-- COUNT(r.DersId) kayıtları sayar. AVG, NULL puanları atlar.
SELECT d.DersKodu, COUNT(r.DersId) AS KayitAdedi,
       AVG(CAST(r.Puan AS decimal(5, 2))) AS Ortalama
FROM bmh236.Ders AS d
LEFT JOIN bmh236.Kayit AS r ON r.DersId = d.DersId
GROUP BY d.DersKodu
HAVING COUNT(r.DersId) >= 2
ORDER BY KayitAdedi DESC, d.DersKodu;

-- Kayıtların dönem içinde puana göre sırasını ve puan durumunu gösterir.
;WITH PuanliKayit AS
(
    SELECT KatilimciId, DersId, Donem, Puan
    FROM bmh236.Kayit
    WHERE Puan IS NOT NULL
)
SELECT KatilimciId, DersId, Donem, Puan,
       ROW_NUMBER() OVER (PARTITION BY Donem ORDER BY Puan DESC, KatilimciId, DersId) AS DonemSirasi,
       CASE WHEN Puan >= 80 THEN N'80 ve üzeri' ELSE N'80 altı' END AS Grup
FROM PuanliKayit
ORDER BY Donem, DonemSirasi;
