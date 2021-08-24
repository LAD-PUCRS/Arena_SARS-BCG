#!/bin/bash
# to run, use:
# nohup bash -c 'time ./run.sh' &> imagej_plugin.log &
JAR=./histogram2csv/Histogram_2_CSV.jar
ROISET=./RoiSet_46diag.zip
PNGsPATH=../dispatcher/output/posProcessamentoPyMol/
OUTPUTPATH=../dispatcher/output/posProcessamentoImageJ/
xvfb-run java -jar $JAR $ROISET $PNGsPATH $OUTPUTPATH
