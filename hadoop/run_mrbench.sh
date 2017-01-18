#!/bin/bash

hadoop jar /usr/local/hadoop/hadoop-mapreduce-client-jobclient-2.6.0-tests.jar \
	mrbench \
	-maps 4 \
	-reduces 2 \
	-inputLines 100000000 \
	-inputType random \
	-numRuns 1

