#!/bin/bash
# to run use:
# nohup bash -c 'time ./run_parallel.sh' &> jobPymol_parallel.log &
N_PROC=32
LOG_PATH=./
date
echo "run $N_PROC process"
for n in $(seq -w 1 $N_PROC); do
#	time ./run.sh &> process$n.log &
	./run.sh &> $LOG_PATH/jobPymol_process$n.log &
	sleep 2
done
wait
cd $LOG_PATH
grep -r "png file created" jobPos01_process*.log
PNG_COUNT=0
for i in `grep -r "png file created" jobPos01_process*.log | sed -e 's/:/ /g' | awk '{print $2}'`; do
	PNG_COUNT=`expr $PNG_COUNT + $i`
done
echo "$PNG_COUNT total png file created"
echo "finish $0"
date
