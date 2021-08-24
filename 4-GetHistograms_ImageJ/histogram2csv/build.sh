#!/bin/bash -e
SRC_PATH="$(dirname "$0")/src"
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/"
JAVAC="$JAVA_HOME/bin/javac"
JAR="$JAVA_HOME/bin/jar"

pushd $SRC_PATH
$JAVAC -cp .:ij.jar Histogram2CSV.java
$JAR cmf manifest.mf ../Histogram_2_CSV.jar \
plugins.config ij.jar ij Histogram2CSV.class Histogram2CSV.java
cp ../Histogram_2_CSV.jar ../ImageJ.app/plugins/Histogram_2_CSV.jar
popd
