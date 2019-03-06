#!/bin/bash

. ambiente.conf

cd $DEV_HOME/bin
$JDK_HOME/bin/java -jar $JAVADECOMPILER_HOME/jd-gui.jar
