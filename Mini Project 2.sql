CREATE TABLE IF NOT EXISTS book_by_title (
    book_id INT,
    title TEXT,
    author TEXT,
    genre TEXT,
    price DECIMAL,
    PRIMARY KEY (title, book_id)
);

CREATE TABLE IF NOT EXISTS book_by_author (
    book_id INT,
    author TEXT,
    title TEXT,
    genre TEXT,
    price DECIMAL,
    PRIMARY KEY (author, book_id)
);

CREATE TABLE IF NOT EXISTS sales_transaction (
    transaction_id INT,
    buyer_id INT,
    book_id INT,
    purchase_date TIMESTAMP,
    price DECIMAL,
    PRIMARY KEY (transaction_id)
);

CREATE TABLE IF NOT EXISTS book_by_buyer (
    buyer_id INT,
    book_id INT,
    title TEXT,
    author TEXT,
    purchase_date TIMESTAMP,
    PRIMARY KEY (buyer_id, book_id)
);

CREATE TABLE IF NOT EXISTS buyer (
    buyer_id INT PRIMARY KEY,
    name TEXT,
    email TEXT
);


--Update tabelnya untuk menghindari hot partition
CREATE TABLE IF NOT EXISTS book_by_title (
    book_id INT,
    title TEXT,
    author TEXT,
    genre TEXT,
    price DECIMAL,
    PRIMARY KEY ((title, genre), book_id)
);

CREATE TABLE IF NOT EXISTS book_by_author (
    book_id INT,
    author TEXT,
    title TEXT,
    genre TEXT,
    price DECIMAL,
    PRIMARY KEY ((author, genre), book_id)
);

CREATE TABLE IF NOT EXISTS sales_transaction (
    transaction_id INT PRIMARY KEY,
    buyer_id INT,
    book_id INT,
    purchase_date TIMESTAMP,
    price DECIMAL
);

CREATE TABLE IF NOT EXISTS book_by_buyer (
    buyer_id INT,
    book_id INT,
    title TEXT,
    author TEXT,
    purchase_date TIMESTAMP,
    PRIMARY KEY ((buyer_id), book_id, purchase_date)
);

CREATE TABLE IF NOT EXISTS buyer (
    buyer_id INT PRIMARY KEY,
    name TEXT,
    email TEXT
);
