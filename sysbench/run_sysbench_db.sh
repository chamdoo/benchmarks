#!/bin/bash

echo "setup MySQL..."
sudo service mysql stop
sudo mysql_install_db --datadir=/media/blueDBM
sudo mysqld --pid-file=./mysql/mysqld.pid --socket=/media/blueDBM/mysqld.sock --datadir=/media/blueDBM &
sleep 5
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock < ./mysql/create.sql

echo "run sysbench with MySQL..."
sudo sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock prepare 
sudo sysbench --test=oltp --oltp-table-size=1000000 --oltp-test-mode=complex --oltp-read-only=off --num-threads=6 --max-time=60 --max-requests=0 --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock run
sudo sysbench --test=oltp --mysql-db=dbtest --mysql-user=root --mysql-socket=/media/blueDBM/mysqld.sock cleanup

echo "remove MySQL..."
sudo mysql --user=root --socket=/media/blueDBM/mysqld.sock < ./mysql/delete.sql
sudo mysqladmin shutdown -S /media/blueDBM/mysqld.sock
