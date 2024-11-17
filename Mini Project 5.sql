--FIle docker-compose.yml
version: '3'
services:
  node1:
    image: cassandra:3.11
    container_name: node1
    environment:
      - CASSANDRA_CLUSTER_NAME=TestCluster
      - CASSANDRA_DC=dc1
      - CASSANDRA_RACK=rack1
      - CASSANDRA_LISTEN_ADDRESS=node1
      - CASSANDRA_SEEDS=node1
      - CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch
    ports:
      - "9042:9042"
    volumes:
      - node1_data:/var/lib/cassandra

  node2:
    image: cassandra:3.11
    container_name: node2
    environment:
      - CASSANDRA_CLUSTER_NAME=TestCluster
      - CASSANDRA_DC=dc1
      - CASSANDRA_RACK=rack1
      - CASSANDRA_LISTEN_ADDRESS=node2
      - CASSANDRA_SEEDS=node1
      - CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch
    ports:
      - "9043:9042"
    volumes:
      - node2_data:/var/lib/cassandra
    depends_on:
      - node1

volumes:
  node1_data:
  node2_data:

--Lalu menyalakan docker compose nya untuk membuat node nya
docker-compose up -d
------------------------------------------------------------------------------
--Edit terlebih dahulu Password untuk Cassandra Security
docker exec -it node1 bash
apt-get update
apt-get install nano
nano /etc/cassandra/cassandra.yaml

--Lalu ganti menjadi seperti ini
authenticator: PasswordAuthenticator
authorizer : CassandraAuthorizer

--Masuk Cassandra Shell
docker exec -it node1 cqlsh

--Buat Keyspace
CREATE KEYSPACE IF NOT EXISTS mini_project5 WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'dc1' : 2};
USE mini_project5;

--------------------------------------------------------------------------------------------------------------------------

--Menggunakan contoh 2 tabel
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

--Buat user
CREATE USER user1 WITH PASSWORD 'password1' NOSUPERUSER ;
CREATE USER user2 WITH PASSWORD 'password2' NOSUPERUSER ;

--Untuk user1 (CRUD di book_by_author, tapi tidak di book_by_title)
GRANT ALL ON mini_project5.book_by_author TO user1; -- CRUD di Tabel B
REVOKE ALL ON mini_project5.book_by_title FROM user1; -- Tidak ada akses ke Tabel A

--Untuk user2 (Hanya SELECT di book_by_title, tapi tidak di book_by_author)
GRANT SELECT ON mini_project5.book_by_title TO user2; -- Hanya SELECT di Tabel A
REVOKE ALL ON mini_project5.book_by_author FROM user2; -- Tidak ada akses ke Tabel B

--Melihat List permission dari masing-masing user
LIST ALL PERMISSIONS OF user1;
LIST ALL PERMISSIONS OF user2;

--Menonaktifkan user default cassandra menjadi nonaktif
ALTER ROLE cassandra WITH LOGIN = false;

--Test Case

--user1
dokcer exec -it node1 cqlsh -u user1 -p password1

--Select
SELECT * FROM mini_project5.book_by_author;

--UPDATE
UPDATE mini_project5.book_by_author 
SET price = 29.99 
WHERE book_id = 1 AND author = 'Author1' AND genre = 'Fiction';

--DELETE
DELETE FROM mini_project5.book_by_author 
WHERE book_id = 1 AND author = 'Author1' AND genre = 'Fiction';

--Select ke tabel A (seharusnya ditolak)
SELECT * FROM mini_project5.book_by_title;


--user2
docker exec -it node1 cqlsh -u user2 -p password2

--Select ke tabel A
SELECT * FROM mini_project5.book_by_title;

--Select ke tabel B (harus nya ditolak)
SELECT * FROM mini_project5.book_by_author;