IF (SELECT COUNT(*) FROM bmh236.Bolum) <> 3
   OR (SELECT COUNT(*) FROM bmh236.Ders) <> 4
   OR (SELECT COUNT(*) FROM bmh236.Katilimci) <> 4
   OR (SELECT COUNT(*) FROM bmh236.Kayit) <> 6
    THROW 50101, N'BMH236 örnek kayıt sayıları doğrulanamadı.', 1;

IF (SELECT COUNT(*) FROM bmh236.Kayit WHERE Puan IS NOT NULL) <> 5
    THROW 50102, N'Puanı beklenen örnek kayıt korunmalı.', 1;

IF (SELECT COUNT(*) FROM sys.foreign_keys
    WHERE OBJECT_SCHEMA_NAME(parent_object_id) = N'bmh236' AND is_disabled = 0) <> 4
    THROW 50103, N'BMH236 yabancı anahtarları eksik.', 1;
GO
