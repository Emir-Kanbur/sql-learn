# BMH236 · SQL Server uygulamaları

Ders konularını izleyen özgün T-SQL alıştırmaları. Veritabanındaki katılımcılar, dersler ve puanlar kurgusaldır. Microsoft SQL Server 2022 için hazırlanmıştır.

## Başlangıç

1. Boş bir alıştırma veritabanı açın ve bağlantıda onu seçin.
2. [setup.sql](setup.sql) betiğini çalıştırın. Betik `bmh236` şemasını kurar ve eksik örnek kayıtları ekler.
3. Her hafta `lesson.sql` örneklerini inceleyin, `exercises.sql` alıştırmalarını çözün ve `solutions.sql` ile karşılaştırın.

| Hafta | Konu |
| --- | --- |
| [1](01-iliskisel-model/) | İlişkisel model, tablolar ve `SELECT` |
| [2](02-er-ve-anahtarlar/) | ER modeli, kardinalite, PK/FK, ara tablo ve normalizasyon |
| [3](03-orm-sorgulari/) | ORM eşlemesinin SQL karşılıkları, filtreleme ve ilişkili kayıtlar |
| [4](04-ddl-ve-butunluk/) | `CREATE`, `ALTER`, `DEFAULT`, `CHECK`, `UNIQUE`, FK ve geri alma |
| [5](05-join-ve-kumeler/) | İç ve dış birleştirmeler, `UNION`, `INTERSECT` ve `EXCEPT` |
| [6](06-raporlama/) | Gruplama, `HAVING`, `CASE`, CTE ve sıralama |
| [7](07-alt-sorgular/) | İlişkili alt sorgular, `EXISTS`, `NOT EXISTS`, `ANY` ve `ALL` |

`Bolum` birden çok `Ders` ve `Katilimci` içerebilir. Bir katılımcı birden çok ders alabilir. `Kayit` bu çoktan çoğa ilişkiyi dönem ve puanla birlikte temsil eder. Verisi bulunmayan bir ders, kaydı bulunmayan bir katılımcı ve henüz puanı girilmemiş bir kayıt, sorguların bu durumlarda nasıl davrandığını göstermek için eklenmiştir.

GitHub Actions aynı kurulumu iki kez çalıştırıp tüm ders ve çözüm sorgularını SQL Server üzerinde sınar.
