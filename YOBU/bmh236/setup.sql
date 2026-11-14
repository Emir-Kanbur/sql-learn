-- SQL Server 2022. Bu betiği alıştırma veritabanında ayrı bir bağlantıyla çalıştırın.
IF @@TRANCOUNT <> 0 OR (@@OPTIONS & 2) = 2
BEGIN
    RAISERROR(N'Kurulumu açık işlem olmadan, otomatik işlem modunda çalıştırın.', 16, 1);
    RETURN;
END;

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @LockResult int;
    EXEC @LockResult = sys.sp_getapplock
        @Resource = N'SqlLearn:BMH236:setup',
        @LockMode = N'Exclusive',
        @LockOwner = N'Transaction',
        @LockTimeout = 10000;

    IF @LockResult < 0
        THROW 50100, N'BMH236 kurulum kilidi alınamadı.', 1;

    IF SCHEMA_ID(N'bmh236') IS NULL
        EXEC(N'CREATE SCHEMA bmh236 AUTHORIZATION dbo;');

    IF OBJECT_ID(N'bmh236.Bolum', N'U') IS NULL
        CREATE TABLE bmh236.Bolum
        (
            BolumId int NOT NULL CONSTRAINT PK_BMH236_Bolum PRIMARY KEY,
            BolumAdi nvarchar(80) NOT NULL CONSTRAINT UQ_BMH236_Bolum_Adi UNIQUE
        );

    IF OBJECT_ID(N'bmh236.Ders', N'U') IS NULL
        CREATE TABLE bmh236.Ders
        (
            DersId int NOT NULL CONSTRAINT PK_BMH236_Ders PRIMARY KEY,
            BolumId int NOT NULL CONSTRAINT FK_BMH236_Ders_Bolum
                REFERENCES bmh236.Bolum (BolumId),
            DersKodu varchar(12) NOT NULL CONSTRAINT UQ_BMH236_Ders_Kod UNIQUE,
            DersAdi nvarchar(80) NOT NULL,
            Kredi tinyint NOT NULL CONSTRAINT CK_BMH236_Ders_Kredi CHECK (Kredi BETWEEN 1 AND 6)
        );

    IF OBJECT_ID(N'bmh236.Katilimci', N'U') IS NULL
        CREATE TABLE bmh236.Katilimci
        (
            KatilimciId int NOT NULL CONSTRAINT PK_BMH236_Katilimci PRIMARY KEY,
            OrnekKodu varchar(12) NOT NULL CONSTRAINT UQ_BMH236_Katilimci_Kod UNIQUE,
            BolumId int NOT NULL CONSTRAINT FK_BMH236_Katilimci_Bolum
                REFERENCES bmh236.Bolum (BolumId)
        );

    IF OBJECT_ID(N'bmh236.Kayit', N'U') IS NULL
        CREATE TABLE bmh236.Kayit
        (
            KatilimciId int NOT NULL CONSTRAINT FK_BMH236_Kayit_Katilimci
                REFERENCES bmh236.Katilimci (KatilimciId),
            DersId int NOT NULL CONSTRAINT FK_BMH236_Kayit_Ders
                REFERENCES bmh236.Ders (DersId),
            Donem varchar(12) NOT NULL,
            Puan tinyint NULL CONSTRAINT CK_BMH236_Kayit_Puan CHECK (Puan BETWEEN 0 AND 100),
            CONSTRAINT PK_BMH236_Kayit PRIMARY KEY (KatilimciId, DersId, Donem)
        );

    INSERT INTO bmh236.Bolum (BolumId, BolumAdi)
    SELECT v.BolumId, v.BolumAdi
    FROM (VALUES (1, N'Yazılım'), (2, N'Tasarım'), (3, N'Robotik')) AS v (BolumId, BolumAdi)
    WHERE NOT EXISTS (SELECT 1 FROM bmh236.Bolum AS b WHERE b.BolumId = v.BolumId);

    INSERT INTO bmh236.Ders (DersId, BolumId, DersKodu, DersAdi, Kredi)
    SELECT v.DersId, v.BolumId, v.DersKodu, v.DersAdi, v.Kredi
    FROM (VALUES
        (10, 1, 'YAZ101', N'Programlama', 4),
        (20, 1, 'YAZ102', N'Veri Modelleme', 3),
        (30, 2, 'TAS101', N'Görsel Tasarım', 3),
        (40, 3, 'ROB101', N'Robotik Temelleri', 2)
    ) AS v (DersId, BolumId, DersKodu, DersAdi, Kredi)
    WHERE NOT EXISTS (SELECT 1 FROM bmh236.Ders AS d WHERE d.DersId = v.DersId);

    INSERT INTO bmh236.Katilimci (KatilimciId, OrnekKodu, BolumId)
    SELECT v.KatilimciId, v.OrnekKodu, v.BolumId
    FROM (VALUES (1, 'K001', 1), (2, 'K002', 1), (3, 'K003', 2), (4, 'K004', 3))
        AS v (KatilimciId, OrnekKodu, BolumId)
    WHERE NOT EXISTS (SELECT 1 FROM bmh236.Katilimci AS k WHERE k.KatilimciId = v.KatilimciId);

    INSERT INTO bmh236.Kayit (KatilimciId, DersId, Donem, Puan)
    SELECT v.KatilimciId, v.DersId, v.Donem, v.Puan
    FROM (VALUES
        (1, 10, 'Guz', 90), (1, 20, 'Guz', 80), (2, 10, 'Guz', 70),
        (2, 20, 'Guz', NULL), (3, 30, 'Guz', 85), (3, 10, 'Bahar', 75)
    ) AS v (KatilimciId, DersId, Donem, Puan)
    WHERE NOT EXISTS (
        SELECT 1 FROM bmh236.Kayit AS k
        WHERE k.KatilimciId = v.KatilimciId AND k.DersId = v.DersId AND k.Donem = v.Donem
    );

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO
