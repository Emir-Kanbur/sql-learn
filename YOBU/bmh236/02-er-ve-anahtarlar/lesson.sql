-- Bolum -> Ders bire çok ilişki. Bölüm adı yalnızca Bolum tablosunda saklanır.
SELECT b.BolumAdi, d.DersKodu, d.DersAdi
FROM bmh236.Bolum AS b
INNER JOIN bmh236.Ders AS d ON d.BolumId = b.BolumId
ORDER BY b.BolumId, d.DersKodu;

-- Katilimci -> Kayit <- Ders, çoktan çoğa ile dönem ve puan için ara tablo.
SELECT k.OrnekKodu, d.DersKodu, r.Donem, r.Puan
FROM bmh236.Kayit AS r
INNER JOIN bmh236.Katilimci AS k ON k.KatilimciId = r.KatilimciId
INNER JOIN bmh236.Ders AS d ON d.DersId = r.DersId
ORDER BY k.OrnekKodu, d.DersKodu, r.Donem;
