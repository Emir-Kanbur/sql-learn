-- Ders kataloğunda her satır bir dersi temsil eder.
SELECT DersKodu, DersAdi, Kredi
FROM bmh236.Ders
ORDER BY DersKodu;

-- Filtreleme ve belirli sayıda satır döndürme.
SELECT TOP (2) DersKodu, DersAdi, Kredi
FROM bmh236.Ders
WHERE Kredi >= 3
ORDER BY Kredi DESC, DersKodu;
