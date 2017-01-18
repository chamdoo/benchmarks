#!/bin/bash

echo "setup MySQL..."
sudo service mysql stop
sudo mysql_install_db --datadir=/media/blueDBM
sudo mysqld --pid-file=./mysql/mysqld.pid --socket=/media/blueDBM/mysqld.sock --datadir=/media/blueDBM &
sleep 5

sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock < ./create_database.sql
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock tpcc1000 < ./create_table.sql
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock tpcc1000 < ./add_fkey_idx.sql

echo "run sysbench with TPCC"
sudo ./tpcc_load 127.0.0.1 tpcc1000 root "" 14

read -p "Press [Enter] key to run TPC-C (RISA)"
echo "RUN ACTUAL TRANSACTIONS"
sudo ./tpcc_start -h 127.0.0.1 -d tpcc1000 -u root -p "" -w 14 -c 16 -r 5 -l 1000 -i 2

echo "remove MySQL..."
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock < ./delete_database.sql
sudo mysqladmin shutdown -S /media/blueDBM/mysqld.sock
