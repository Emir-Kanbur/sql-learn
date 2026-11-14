SELECT k.OrnekKodu
FROM bmh236.Katilimci AS k
LEFT JOIN bmh236.Kayit AS r ON r.KatilimciId = k.KatilimciId
WHERE r.KatilimciId IS NULL
ORDER BY k.OrnekKodu;

SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 10
EXCEPT
SELECT KatilimciId FROM bmh236.Kayit WHERE DersId = 20
ORDER BY KatilimciId;
