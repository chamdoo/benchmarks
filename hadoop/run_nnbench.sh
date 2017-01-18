#!/bin/bash

hadoop jar /usr/local/hadoop/hadoop-mapreduce-client-jobclient-2.6.0-tests.jar \
	nnbench \
	-operation create_write \
    -maps 12 -reduces 6 -blockSize 1 -bytesToWrite 0 -numberOfFiles 1000 \
    -replicationFactorPerFile 3 -readFileAfterOpen true \
    -baseDir /benchmarks/NNBench-`hostname -s`

