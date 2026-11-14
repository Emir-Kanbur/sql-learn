SELECT k.OrnekKodu, b.BolumAdi, d.DersKodu, r.Donem
FROM bmh236.Katilimci AS k
INNER JOIN bmh236.Bolum AS b ON b.BolumId = k.BolumId
INNER JOIN bmh236.Kayit AS r ON r.KatilimciId = k.KatilimciId
INNER JOIN bmh236.Ders AS d ON d.DersId = r.DersId
ORDER BY k.OrnekKodu, d.DersKodu, r.Donem;

-- Donem, katılımcı ve dersle birlikte aynı dersin farklı dönemlerde alınabilmesini sağlar.
