-- Hiç kayıt almamış dersler de listelenir. Dönem filtresi ON içindedir.
SELECT d.DersKodu, r.KatilimciId, r.Puan
FROM bmh236.Ders AS d
LEFT JOIN bmh236.Kayit AS r ON r.DersId = d.DersId AND r.Donem = 'Guz'
ORDER BY d.DersKodu, r.KatilimciId;

-- RIGHT JOIN, sağdaki Ders tablosunun eşleşmeyen satırlarını korur.
SELECT d.DersKodu, r.KatilimciId
FROM bmh236.Kayit AS r
RIGHT JOIN bmh236.Ders AS d ON r.DersId = d.DersId AND r.Donem = 'Guz'
ORDER BY d.DersKodu, r.KatilimciId;

-- FULL OUTER JOIN, iki dönemin katılımcı kümelerini eşleşmeyenlerle birlikte karşılaştırır.
SELECT guz.KatilimciId AS GuzKodu, bahar.KatilimciId AS BaharKodu
FROM (SELECT DISTINCT KatilimciId FROM bmh236.Kayit WHERE Donem = 'Guz') AS guz
FULL OUTER JOIN (SELECT DISTINCT KatilimciId FROM bmh236.Kayit WHERE Donem = 'Bahar') AS bahar
    ON bahar.KatilimciId = guz.KatilimciId
ORDER BY COALESCE(guz.KatilimciId, bahar.KatilimciId);

-- Her iki derse de kayıtlı katılımcılar.
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 10 AND Donem = 'Guz'
INTERSECT
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 20 AND Donem = 'Guz'
ORDER BY KatilimciId;

-- En az birinde kayıtlı katılımcılar. UNION yinelenenleri kaldırır.
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 10
UNION
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 30
ORDER BY KatilimciId;

-- UNION ALL, aynı katılımcı birden fazla kayıtta yer alıyorsa her satırı korur.
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 10
UNION ALL
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 30
ORDER BY KatilimciId;

-- Kataloğa kayıtlı olup hiçbir derse kayıt yaptırmamış katılımcılar.
SELECT KatilimciId FROM bmh236.Katilimci
EXCEPT
SELECT KatilimciId FROM bmh236.Kayit
ORDER BY KatilimciId;
