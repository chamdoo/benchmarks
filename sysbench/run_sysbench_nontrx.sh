#!/bin/bash

echo "setup MySQL..."
sudo service mysql stop
sudo mysql_install_db --datadir=/media/blueDBM
sudo mysqld --pid-file=./mysql/mysqld.pid --socket=/media/blueDBM/mysqld.sock --datadir=/media/blueDBM &
sleep 5
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock < ./mysql/create.sql

echo "run sysbench with MySQL..."
sudo sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock prepare 
sudo sysbench --test=oltp --oltp-table-size=1000000 --oltp-test-mode=nontrx --oltp-nontrx-mode=select --oltp-read-only=off --num-threads=6 --max-requests=100000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock run
sudo sysbench --test=oltp --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock cleanup

sudo sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock prepare 
sudo sysbench --test=oltp --oltp-table-size=1000000 --oltp-test-mode=nontrx --oltp-nontrx-mode=update_key --oltp-read-only=off --num-threads=6 --max-requests=100000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock run
sudo sysbench --test=oltp --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock cleanup

sudo sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock prepare 
sudo sysbench --test=oltp --oltp-table-size=1000000 --oltp-test-mode=nontrx --oltp-nontrx-mode=update_nokey --oltp-read-only=off --num-threads=6 --max-requests=100000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock run
sudo sysbench --test=oltp --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock cleanup

sudo sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock prepare 
sudo sysbench --test=oltp --oltp-table-size=1000000 --oltp-test-mode=nontrx --oltp-nontrx-mode=insert --oltp-read-only=off --num-threads=6 --max-requests=100000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock run
sudo sysbench --test=oltp --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock cleanup

sudo sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock prepare 
sudo sysbench --test=oltp --oltp-table-size=1000000 --oltp-test-mode=nontrx --oltp-nontrx-mode=delete --oltp-read-only=off --num-threads=6 --max-requests=100000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock run
sudo sysbench --test=oltp --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock cleanup


echo "remove MySQL..."
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock < ./mysql/delete.sql
sudo mysqladmin shutdown -S /media/blueDBM/mysqld.sock
