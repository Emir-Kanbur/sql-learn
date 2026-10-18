# SQL Öğrenme Deposu

Microsoft SQL Server üzerinde SQL pratiği yapmak için kişisel öğrenme deposu. Örnekler T-SQL kullanır; `YOBU/` klasörü üniversite çalışmaları için ayrılmıştır.

> **Herkese açık depo:** `YOBU/` içine yüklemeden önce ödevlerin ve ders materyallerinin paylaşılmasına izin verildiğini kontrol et; kişisel veya üniversiteye özel bilgileri ekleme. YouTube videolarını, ders notlarını, slaytları, transkriptleri ya da başkasına ait çözümleri izinsiz kopyalamak yerine kaynak bağlantısını ve kendi notlarını ekle. Depoda lisans bulunmadığından içerik için açık bir yeniden kullanım izni verilmiş değildir.

## Gerekenler

- Microsoft SQL Server (yerel kurulum veya erişimin olan bir sunucu)
- Sorguları çalıştırmak için SQL Server Management Studio (SSMS) ya da Visual Studio Code'daki MSSQL eklentisi

## Başlangıç

1. SQL Server'a bağlan ve `SqlLearn` adında boş bir veritabanı oluştur:

   ```sql
   CREATE DATABASE SqlLearn;
   ```

2. `SqlLearn` veritabanını seçip [`setup.sql`](./setup.sql) dosyasını çalıştır. Dosya örnek tabloları ve verileri oluşturur; tekrar çalıştırıldığında mevcut örnek kayıtları çoğaltmaz.
3. [`lessons/01-select/lesson.sql`](./lessons/01-select/lesson.sql) dosyasındaki örnekleri sırayla çalıştır.
4. Önce [`lessons/01-select/exercises.sql`](./lessons/01-select/exercises.sql) alıştırmalarını kendin çöz. Takıldığında [`lessons/01-select/solutions.sql`](./lessons/01-select/solutions.sql) dosyasına bak.

> `CREATE DATABASE` iznin yoksa, sunucu yöneticinden bir veritabanı oluşturmasını iste ve `setup.sql` dosyasını o veritabanına bağlıyken çalıştır.

## Örnek şema

- `Customers`: müşteriler
- `Products`: ürünler
- `SalesOrders`: siparişler
- `OrderItems`: sipariş satırları

## Klasörler

- [`YOBU/`](./YOBU/): Üniversite dersleri, çalışmalar ve ödevler.
- [`learn/`](./learn/): SQL eğitim notları, örnekler ve kişisel pratik.
- [`lessons/`](./lessons/): Bu deponun adım adım SQL Server dersleri ve alıştırmaları.

## Ders sırası

1. `SELECT`, sütun seçimi, `WHERE` ve `ORDER BY`
2. Sonraki adım: `JOIN` ile tabloları birleştirme
3. Sonraki adım: `GROUP BY`, toplama fonksiyonları ve `HAVING`
4. Sonraki adım: alt sorgular, CTE'ler ve veri değiştirme komutları

Her yeni konu için `lessons/` altında ayrı bir klasör açıp örnekleri, alıştırmaları ve çözümleri ayrı dosyalarda tutabilirsin.
