#!/bin/bash

hadoop jar /usr/local/hadoop/hadoop-mapreduce-client-jobclient-2.6.0-tests.jar TestDFSIO -write -nrFiles 6 -fileSize 1000

