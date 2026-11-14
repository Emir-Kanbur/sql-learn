-- En az bir puanı bulunan katılımcıları döndürür.
SELECT k.OrnekKodu
FROM bmh236.Katilimci AS k
WHERE EXISTS (SELECT 1 FROM bmh236.Kayit AS r WHERE r.KatilimciId = k.KatilimciId AND r.Puan IS NOT NULL)
ORDER BY k.OrnekKodu;

-- Karşılaştırmadan önce NULL puanlar dışarıda bırakılır.
SELECT KatilimciId, Puan
FROM bmh236.Kayit
WHERE DersId = 10 AND Donem = 'Guz'
    AND Puan >= ALL (SELECT Puan FROM bmh236.Kayit WHERE DersId = 20 AND Donem = 'Guz' AND Puan IS NOT NULL)
ORDER BY Puan DESC, KatilimciId;

-- En az bir puandan yüksek olmak (ANY).
SELECT KatilimciId, Puan
FROM bmh236.Kayit
WHERE DersId = 10 AND Donem = 'Guz'
    AND Puan > ANY (SELECT Puan FROM bmh236.Kayit WHERE DersId = 20 AND Donem = 'Guz' AND Puan IS NOT NULL)
ORDER BY Puan DESC, KatilimciId;

-- Bölüm 1'in bütün derslerine Güz döneminde kayıt yaptıranlar.
SELECT k.OrnekKodu
FROM bmh236.Katilimci AS k
WHERE NOT EXISTS (
    SELECT 1 FROM bmh236.Ders AS d
    WHERE d.BolumId = 1 AND NOT EXISTS (
        SELECT 1 FROM bmh236.Kayit AS r
        WHERE r.KatilimciId = k.KatilimciId AND r.DersId = d.DersId AND r.Donem = 'Guz'
    )
)
ORDER BY k.OrnekKodu;
