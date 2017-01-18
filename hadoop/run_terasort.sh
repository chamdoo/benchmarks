#!/bin/bash

hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar teragen 5000000 /user/hduser/terasort-input1
hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar teragen 5000000 /user/hduser/terasort-input2
hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar teragen 5000000 /user/hduser/terasort-input3

hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar terasort /user/hduser/terasort-input1 /user/hduser/terasort-output1 &
hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar terasort /user/hduser/terasort-input2 /user/hduser/terasort-output2 &
hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar terasort /user/hduser/terasort-input3 /user/hduser/terasort-output3 &

for job in `jobs -p`
do
	echo $job
	wait $job
done

hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar teravalidate /user/hduser/terasort-output1 /user/hduser/terasort-validate1 &
hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar teravalidate /user/hduser/terasort-output2 /user/hduser/terasort-validate2 &
hadoop jar /usr/local/hadoop/hadoop-mapreduce-examples-2.6.0.jar teravalidate /user/hduser/terasort-output3 /user/hduser/terasort-validate3 &

for job in `jobs -p`
do
	echo $job
	wait $job
done

hadoop fs -cat /user/hduser/terasort-validate1/part-r-00000
hadoop fs -cat /user/hduser/terasort-validate2/part-r-00000
hadoop fs -cat /user/hduser/terasort-validate3/part-r-00000
