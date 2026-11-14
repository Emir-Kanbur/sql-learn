# SQL Öğrenme Deposu

Microsoft SQL Server üzerinde SQL pratiği yapmak için kişisel öğrenme deposu. Örnekler T-SQL kullanır; `YOBU/` klasörü üniversite çalışmaları için ayrılmıştır.

> **Herkese açık depo:** `YOBU/` içine yüklemeden önce ödevlerin ve ders materyallerinin paylaşılmasına izin verildiğini kontrol et; kişisel veya üniversiteye özel bilgileri ekleme. YouTube videolarını, ders notlarını, slaytları, transkriptleri ya da başkasına ait çözümleri izinsiz kopyalamak yerine kaynak bağlantısını ve kendi notlarını ekle. Depoda lisans bulunmadığından içerik için açık bir yeniden kullanım izni verilmiş değildir.

## Gerekenler

- Microsoft SQL Server (yerel kurulum veya erişimin olan bir sunucu)
- Sorguları çalıştırmak için SQL Server Management Studio (SSMS) ya da Visual Studio Code'daki MSSQL eklentisi

## Başlangıç

1. SQL Server'a bağlan ve alıştırmalar için boş bir veritabanı oluştur. Örneğin:

   ```sql
   CREATE DATABASE SqlLearn;
   ```

2. Oluşturduğun veritabanını seç ve [`setup.sql`](./setup.sql) dosyasını çalıştır. Kurulum tabloları ve örnek kayıtları tek işlemde oluşturur. Tekrar çalıştırıldığında yalnızca eksik kimlikleri ekler.
3. Aynı veritabanında aşağıdaki dersleri sırayla aç. Her klasörde `lesson.sql` örnekleri, `exercises.sql` soruları ve `solutions.sql` çözümleri içerir.

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

1. [SELECT](./lessons/01-select/) ile sütun seçimi, `WHERE` ve `ORDER BY`
2. [JOIN](./lessons/02-join/) ile tabloları birleştirme
3. [GROUP BY](./lessons/03-group-by/) ile gruplama, toplama fonksiyonları ve `HAVING`

## Otomatik doğrulama

GitHub Actions, geçici bir SQL Server 2022 örneğinde kurulumu iki kez çalıştırır, örnek kayıtları kontrol eder ve tüm ders ve çözüm sorgularını yürütür. Aynı kontrolü Docker ve OpenSSL bulunan x86-64 Linux ortamında çalıştırabilirsin:

```sh
bash scripts/check-sql.sh
```
