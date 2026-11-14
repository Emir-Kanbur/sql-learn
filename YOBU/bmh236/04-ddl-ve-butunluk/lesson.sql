-- Bu ders işlemi kendisi açar ve geri alır.
IF @@TRANCOUNT <> 0 OR (@@OPTIONS & 2) = 2
    THROW 50104, N'Dersi açık işlem olmadan, otomatik işlem modunda çalıştırın.', 1;

-- Geçici tablo kullanarak kısıtlar ve değişiklikler.
CREATE TABLE #Kontenjan
(
    KontenjanId int NOT NULL PRIMARY KEY,
    Etiket varchar(20) NOT NULL UNIQUE,
    BosYer int NOT NULL DEFAULT (0) CHECK (BosYer >= 0)
);
ALTER TABLE #Kontenjan ADD Acik bit NOT NULL DEFAULT (1);

INSERT INTO #Kontenjan (KontenjanId, Etiket) VALUES (1, 'LAB-A');

BEGIN TRANSACTION;
    UPDATE #Kontenjan SET BosYer = 3 WHERE KontenjanId = 1;
    SELECT Etiket, BosYer, Acik FROM #Kontenjan;
ROLLBACK TRANSACTION;

SELECT Etiket, BosYer, Acik FROM #Kontenjan;
DROP TABLE #Kontenjan;

-- Kalıcı örnek tablolardaki yabancı anahtarları inceleyin.
SELECT OBJECT_NAME(parent_object_id) AS Cocuk, OBJECT_NAME(referenced_object_id) AS Ebeveyn
FROM sys.foreign_keys
WHERE OBJECT_SCHEMA_NAME(parent_object_id) = 'bmh236'
ORDER BY Cocuk, Ebeveyn;
