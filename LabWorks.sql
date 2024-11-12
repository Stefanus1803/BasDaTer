--Membuat Keyspace Online Book Sales
CREATE KEYSPACE online_book_sales WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1 };

-- Menambahkan index pada tabel book_by_title untuk pencarian berdasarkan genre
CREATE INDEX IF NOT EXISTS idx_genre_on_book_by_title ON book_by_title (genre);

-- Menambahkan index pada tabel book_by_author untuk pencarian berdasarkan genre
CREATE INDEX IF NOT EXISTS idx_genre_on_book_by_author ON book_by_author (genre);

-- Menambahkan index pada tabel sales_transaction untuk pencarian berdasarkan buyer_id
CREATE INDEX IF NOT EXISTS idx_buyer_id_on_sales_transaction ON sales_transaction (buyer_id);

-- Menambahkan index pada tabel book_by_buyer untuk pencarian berdasarkan title
CREATE INDEX IF NOT EXISTS idx_title_on_book_by_buyer ON book_by_buyer (title);


--Memasukkan Sekaligus Data Per Tabel

BEGIN BATCH
    -- Masukkan data ke dalam tabel book_by_title
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (1, 'Doraemon', 'Fujiko F Fujio', 'Manga', 50000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (2, 'Simbol Natural', 'Junius Karel Tampubolon', 'Filsafat', 80000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (3, 'Institute of Christian Religion', 'John Calvin', 'Teologi', 100000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (4, 'Bondage of Will', 'Martin Luther', 'Teologi', 90000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (5, 'Mazmur Jenewa', 'Theodore Beza', 'Teologi', 75000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (6, 'Entrok', 'Okky Madasari', 'Fiksi', 65000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (7, 'On Trinity', 'Santo Agustinus', 'Teologi', 95000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (8, 'Matematika Kelas XII', 'Noor Hidayat', 'Pendidikan', 70000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (9, 'Mazmur Skotlandia', 'John Knox', 'Teologi', 72000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (10, 'Kidung Jemaat', 'Yamuger', 'Religi', 60000);

APPLY BATCH;

BEGIN BATCH
    -- Masukkan data ke dalam tabel book_by_author
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (1, 'Fujiko F Fujio', 'Doraemon', 'Manga', 50000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (2, 'Junius Karel Tampubolon', 'Simbol Natural', 'Filsafat', 80000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (3, 'John Calvin', 'Institute of Christian Religion', 'Teologi', 100000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (4, 'Martin Luther', 'Bondage of Will', 'Teologi', 90000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (5, 'Theodore Beza', 'Mazmur Jenewa', 'Teologi', 75000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (6, 'Okky Madasari', 'Entrok', 'Fiksi', 65000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (7, 'Santo Agustinus', 'On Trinity', 'Teologi', 95000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (8, 'Noor Hidayat', 'Matematika Kelas XII', 'Pendidikan', 70000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (9, 'John Knox', 'Mazmur Skotlandia', 'Teologi', 72000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (10, 'Yamuger', 'Kidung Jemaat', 'Religi', 60000);

APPLY BATCH;

BEGIN BATCH
    -- Masukkan data ke dalam tabel sales_transaction
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (1, 1, 1, toTimestamp(now()), 50000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (2, 2, 2, toTimestamp(now()), 80000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (3, 3, 3, toTimestamp(now()), 100000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (4, 4, 4, toTimestamp(now()), 90000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (5, 5, 5, toTimestamp(now()), 75000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (6, 6, 6, toTimestamp(now()), 65000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (7, 7, 7, toTimestamp(now()), 95000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (8, 8, 8, toTimestamp(now()), 70000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (9, 9, 9, toTimestamp(now()), 72000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (10, 10, 10, toTimestamp(now()), 60000);

APPLY BATCH;

BEGIN BATCH
    -- Masukkan data ke dalam tabel book_by_buyer
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (1, 1, 'Doraemon', 'Fujiko F Fujio', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (2, 2, 'Simbol Natural', 'Junius Karel Tampubolon', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (3, 3, 'Institute of Christian Religion', 'John Calvin', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (4, 4, 'Bondage of Will', 'Martin Luther', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (5, 5, 'Mazmur Jenewa', 'Theodore Beza', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (6, 6, 'Entrok', 'Okky Madasari', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (7, 7, 'On Trinity', 'Santo Agustinus', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (8, 8, 'Matematika Kelas XII', 'Noor Hidayat', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (9, 9, 'Mazmur Skotlandia', 'John Knox', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (10, 10, 'Kidung Jemaat', 'Yamuger', toTimestamp(now()));

APPLY BATCH;

BEGIN BATCH
    -- Masukkan data ke dalam tabel buyer
    INSERT INTO buyer (buyer_id, name, email) VALUES (1, 'Mas Panjul', 'maspanjul@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (2, 'Bayu', 'bayu@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (3, 'Cahyo', 'cahyo@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (4, 'Yokanan', 'yokanan@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (5, 'Nahason', 'nahason@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (6, 'John', 'john@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (7, 'Sule', 'sule@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (8, 'Tan Swie Bing', 'tan@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (9, 'Mbak Noor', 'mbaknoor@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (10, 'Mas Hanafi', 'mashanafi@example.com');

APPLY BATCH;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Memasukkan data sekaligus banyak ke banyak tabel

BEGIN BATCH
    -- Masukkan data ke dalam tabel book_by_title
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (1, 'Doraemon', 'Fujiko F Fujio', 'Manga', 50000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (2, 'Simbol Natural', 'Junius Karel Tampubolon', 'Filsafat', 80000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (3, 'Institute of Christian Religion', 'John Calvin', 'Teologi', 100000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (4, 'Bondage of Will', 'Martin Luther', 'Teologi', 90000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (5, 'Mazmur Jenewa', 'Theodore Beza', 'Teologi', 75000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (6, 'Entrok', 'Okky Madasari', 'Fiksi', 65000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (7, 'On Trinity', 'Santo Agustinus', 'Teologi', 95000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (8, 'Matematika Kelas XII', 'Noor Hidayat', 'Pendidikan', 70000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (9, 'Mazmur Skotlandia', 'John Knox', 'Teologi', 72000);
    INSERT INTO book_by_title (book_id, title, author, genre, price) VALUES (10, 'Kidung Jemaat', 'Yamuger', 'Religi', 60000);

    -- Masukkan data ke dalam tabel book_by_author
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (1, 'Fujiko F Fujio', 'Doraemon', 'Manga', 50000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (2, 'Junius Karel Tampubolon', 'Simbol Natural', 'Filsafat', 80000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (3, 'John Calvin', 'Institute of Christian Religion', 'Teologi', 100000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (4, 'Martin Luther', 'Bondage of Will', 'Teologi', 90000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (5, 'Theodore Beza', 'Mazmur Jenewa', 'Teologi', 75000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (6, 'Okky Madasari', 'Entrok', 'Fiksi', 65000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (7, 'Santo Agustinus', 'On Trinity', 'Teologi', 95000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (8, 'Noor Hidayat', 'Matematika Kelas XII', 'Pendidikan', 70000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (9, 'John Knox', 'Mazmur Skotlandia', 'Teologi', 72000);
    INSERT INTO book_by_author (book_id, author, title, genre, price) VALUES (10, 'Yamuger', 'Kidung Jemaat', 'Religi', 60000);

    -- Masukkan data ke dalam tabel sales_transaction
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (1, 1, 1, toTimestamp(now()), 50000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (2, 2, 2, toTimestamp(now()), 80000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (3, 3, 3, toTimestamp(now()), 100000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (4, 4, 4, toTimestamp(now()), 90000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (5, 5, 5, toTimestamp(now()), 75000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (6, 6, 6, toTimestamp(now()), 65000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (7, 7, 7, toTimestamp(now()), 95000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (8, 8, 8, toTimestamp(now()), 70000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (9, 9, 9, toTimestamp(now()), 72000);
    INSERT INTO sales_transaction (transaction_id, buyer_id, book_id, purchase_date, price) VALUES (10, 10, 10, toTimestamp(now()), 60000);

    -- Masukkan data ke dalam tabel book_by_buyer
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (1, 1, 'Doraemon', 'Fujiko F Fujio', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (2, 2, 'Simbol Natural', 'Junius Karel Tampubolon', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (3, 3, 'Institute of Christian Religion', 'John Calvin', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (4, 4, 'Bondage of Will', 'Martin Luther', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (5, 5, 'Mazmur Jenewa', 'Theodore Beza', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (6, 6, 'Entrok', 'Okky Madasari', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (7, 7, 'On Trinity', 'Santo Agustinus', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (8, 8, 'Matematika Kelas XII', 'Noor Hidayat', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (9, 9, 'Mazmur Skotlandia', 'John Knox', toTimestamp(now()));
    INSERT INTO book_by_buyer (buyer_id, book_id, title, author, purchase_date) VALUES (10, 10, 'Kidung Jemaat', 'Yamuger', toTimestamp(now()));

    -- Masukkan data ke dalam tabel buyer
    INSERT INTO buyer (buyer_id, name, email) VALUES (1, 'Mas Panjul', 'maspanjul@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (2, 'Bayu', 'bayu@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (3, 'Cahyo', 'cahyo@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (4, 'Yokanan', 'yokanan@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (5, 'Nahason', 'nahason@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (6, 'John', 'john@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (7, 'Sule', 'sule@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (8, 'Tan Swie Bing', 'tan@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (9, 'Mbak Noor', 'mbaknoor@example.com');
    INSERT INTO buyer (buyer_id, name, email) VALUES (10, 'Mas Hanafi', 'mashanafi@example.com');

APPLY BATCH;