-- ORM filtreleme ve projeksiyonunun SQL karşılığı. Parametre tek yerde tanımlanır.
DECLARE @MinKredi tinyint = 3;

SELECT d.DersId, d.DersKodu, d.DersAdi
FROM bmh236.Ders AS d
WHERE d.Kredi >= @MinKredi
ORDER BY d.DersKodu;

-- İlişkili nesneleri yüklemek için gereken satırlar. Bir ders birden çok kayıtla dönebilir.
SELECT d.DersId, d.DersKodu, r.KatilimciId, r.Donem, r.Puan
FROM bmh236.Ders AS d
LEFT JOIN bmh236.Kayit AS r ON r.DersId = d.DersId
ORDER BY d.DersId, r.KatilimciId, r.Donem;
