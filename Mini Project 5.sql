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

--Lalu menyalakan docker compose nya
docker-compose up -d

--Edit terlebih dahulu Password
docker exec -it node1 bash
apt-get update
apt-get install nano
nano /etc/cassandra/cassandra.yaml

--ganti menjadi seperti ini
authenticator: PasswordAuthenticator
authorizer : CassandraAuthorizer

--Masuk Cassandra Shell
docker exec -it node1 cqlsh

--Buat Keyspace
CREATE KEYSPACE IF NOT EXISTS mini_project5 WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'dc1' : 2};
USE mini_project5;

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


