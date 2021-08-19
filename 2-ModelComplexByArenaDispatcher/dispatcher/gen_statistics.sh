#!/bin/bash
OUTPUT_DIR="output/"

if [ -d $OUTPUT_DIR ]; then
	cd $OUTPUT_DIR

	for i in `ls *.log`; do
		OUT_FILE="`echo $i | sed 's/.log//'`.error_count"
		if [ ! -f $OUT_FILE ]; then
			cat $i | grep ERROR | wc -l >  $OUT_FILE
			echo "$OUT_FILE created"
		fi

		OUT_FILE="`echo $i | sed 's/.log//'`.fail_count"
		if [ ! -f $OUT_FILE ]; then
			cat $i | grep "ERROR 5" | wc -l > $OUT_FILE
			echo "$OUT_FILE created"
		fi

		OUT_FILE="`echo $i | sed 's/.log//'`.fail_list"
		if [ ! -f $OUT_FILE ]; then
			cat $i | grep "ERROR 5" | awk '{print $7}' >  $OUT_FILE
			echo "$OUT_FILE created"
		fi
	done
else
	echo "output directory($OUTPUT_DIR) not found"
fi