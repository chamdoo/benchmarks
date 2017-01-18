#!/bin/bash

sudo chown -R hduser.hadoop /media/blueDBM/
sudo rm -rf /media/blueDBM/datanode
sudo rm -rf /media/blueDBM/namenode
sudo rm -rf /media/blueDBM/tmp

hdfs namenode -format
start-dfs.sh
start-yarn.sh
hdfs dfsadmin -safemode leave
