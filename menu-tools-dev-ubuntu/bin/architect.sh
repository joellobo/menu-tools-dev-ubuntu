#!/bin/bash

. ambiente.conf

cd $SAJ_DEV_HOME/bin
$JDK_HOME/bin/java -jar $ARCHITECT_HOME/architect.jar
