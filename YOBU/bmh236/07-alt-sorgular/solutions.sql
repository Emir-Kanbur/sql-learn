SELECT d.DersKodu
FROM bmh236.Ders AS d
WHERE NOT EXISTS (SELECT 1 FROM bmh236.Kayit AS r WHERE r.DersId = d.DersId)
ORDER BY d.DersKodu;

SELECT r.DersId, r.KatilimciId, r.Donem, r.Puan
FROM bmh236.Kayit AS r
WHERE r.Puan > (
    SELECT AVG(CAST(d.Puan AS decimal(5, 2)))
    FROM bmh236.Kayit AS d
    WHERE d.DersId = r.DersId AND d.Puan IS NOT NULL
)
ORDER BY r.DersId, r.Puan DESC, r.KatilimciId, r.Donem;
