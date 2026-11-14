CREATE TABLE #Raf
(
    RafKodu varchar(12) NOT NULL UNIQUE,
    Adet int NOT NULL DEFAULT (0) CHECK (Adet >= 0)
);

INSERT INTO #Raf (RafKodu) VALUES ('R-01');
SELECT RafKodu, Adet FROM #Raf;
DROP TABLE #Raf;
