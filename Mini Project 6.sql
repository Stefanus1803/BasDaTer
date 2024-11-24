--WITH DOCKER 

--Isi File docker compose.yml
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

--Buat Keyspace dan Tabel

CREATE KEYSPACE mp6_project WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 2};

CREATE TABLE IF NOT EXISTS book_by_title (
    book_id INT,
    title TEXT,
    author TEXT,
    genre TEXT,
    price DECIMAL,
    PRIMARY KEY (title, book_id)
);

--Buat Index untuk nanti filter data
CREATE INDEX ON book_by_title (genre);


--Masuk ke dalam nodenya, lalu install pip
apt-get update && apt-get upgrade -y
apt-get install python3 python3-pip
pip3 install cassandra-driver


--Script Koneksi
from cassandra.cluster import Cluster

try:
    # Koneksi ke cluster Cassandra
    cluster = Cluster(['node1'])  --Gunakan localhost jika di host atau node1 jika di Docker
    session = cluster.connect('mp6_project')

    if session:
        print("Koneksi sukses")
    else:
        print("Koneksi gagal")
except Exception as e:
    print(f"Koneksi gagal: {e}")

--Script Insert Data
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider

try:
    # Koneksi ke cluster menggunakan nama layanan Docker (node1, node2)
    cluster = Cluster(['node1', 'node2'])  # Host Cassandra
    session = cluster.connect()

    # Pilih keyspace
    session.set_keyspace('mp6_project')

    # Data yang akan di-insert
    books = [
        (1, "To Kill a Mockingbird", "Harper Lee", "Fiction", 10.99),
        (2, "1984", "George Orwell", "Dystopian", 9.99),
        (3, "The Great Gatsby", "F. Scott Fitzgerald", "Classic", 14.99),
        (4, "The Catcher in the Rye", "J.D. Salinger", "Fiction", 8.99),
        (5, "Moby Dick", "Herman Melville", "Adventure", 11.99),
    ]

    # Query insert
    query = """
    INSERT INTO book_by_title (book_id, title, author, genre, price)
    VALUES (%s, %s, %s, %s, %s);
    """

    # Insert data
    for book in books:
        session.execute(query, book)
        print(f"Data inserted: {book}")

    print("Semua data berhasil di-insert.")

except Exception as e:
    print(f"Terjadi kesalahan: {e}")

finally:
    if 'cluster' in locals():
        cluster.shutdown()

-- Script Retrive All Data
from cassandra.cluster import Cluster

try:
    # Koneksi ke node2
    cluster = Cluster(['node2'])  # Node selain seeder
    session = cluster.connect()

    # Pilih keyspace
    session.set_keyspace('mp6_project')

    # Query untuk mengambil semua data
    query = "SELECT * FROM book_by_title;"
    rows = session.execute(query)

    # Menampilkan semua data
    print("Data dalam tabel 'book_by_title':")
    for row in rows:
        print(f"Book ID: {row.book_id}, Title: {row.title}, Author: {row.author}, Genre: {row.genre}, Price: {row.price}")

except Exception as e:
    print(f"Terjadi kesalahan: {e}")

finally:
    if 'cluster' in locals():
        cluster.shutdown()

--Script Filtered Data
from cassandra.cluster import Cluster

try:
    # Koneksi ke node selain seeder (node2)
    cluster = Cluster(['node2'])  # Koneksi ke node2
    session = cluster.connect()

    # Pilih keyspace
    session.set_keyspace('mp6_project')

    # Query untuk mengambil data dengan filter menggunakan index (contoh: genre 'Fiction')
    genre_filter = 'Fiction'  # Filter berdasarkan genre
    query = "SELECT * FROM book_by_title WHERE genre = %s;"
    
    # Eksekusi query dengan parameter
    rows = session.execute(query, (genre_filter,))

    # Menampilkan data yang difilter
    print(f"Data dengan genre '{genre_filter}':")
    for row in rows:
        print(f"Book ID: {row.book_id}, Title: {row.title}, Author: {row.author}, Genre: {row.genre}, Price: {row.price}")

except Exception as e:
    print(f"Terjadi kesalahan: {e}")

finally:
    if 'cluster' in locals():
        cluster.shutdown()




--Cassandra client driver with tarball

curl -OL https://dlcdn.apache.org/cassandra/4.1.7/apache-cassandra-4.1.7-bin.tar.gz
sudo tar -xzf apache-cassandra-4.1.7-bin.tar.gz
sudo mv apache-cassandra-4.1.7 cassandra
cd cassandra
sudo su
mkdir -p /var/lib/cassandra/{data,commitlog,saved_caches}
mkdir -p /var/log/cassandra
chmod 777 /var/lib/cassandra
chmod 777 /var/log/cassandra

sudo dnf install java-11-amazon-corretto-devel 
sudo yum install python3-pip
sudo dnf groupinstall 'Development Tools'
sudo dnf install -y openssl-devel bzip2-devel
sudo dnf install -y openssl-devel bzip2-devel libffi-devel zlib-devel

cd /opt
sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
sudo tar -xzf Python-3.8.12.tgz
cd Python-3.8.12
sudo ./configure --enable-optimizations
sudo make altinstall
python3.8 --version
sudo rm -rf /opt/Python-3.8.12
sudo alternatives --install/usr/bin/python3 python3 /usr/local/bin/python3.8.12 python3 get-pip.py

python3 get-pip.py
pip install cassandra-driver

--alternatif kalau step dari alternatives tidak bisa
curl -O https://bootstrap.pypa.io/get-pip.py
ls
python3.8 get-pip.py 
pip install cassandra-driver

--menjalankan cassandra
cd cassandra/bin
./cassandra -f -R
