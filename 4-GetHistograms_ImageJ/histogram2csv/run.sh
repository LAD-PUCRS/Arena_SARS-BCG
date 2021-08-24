#!/bin/bash -e

SCRIPT_PATH=$(dirname "$0")
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/"
JAVA="$JAVA_HOME/bin/java"
CLASSPATH="$SCRIPT_PATH/src"
$JAVA -cp $CLASSPATH Histogram2CSV $@
