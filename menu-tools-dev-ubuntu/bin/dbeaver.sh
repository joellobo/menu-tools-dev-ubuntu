#!/bin/bash

. ambiente.conf

cd $SAJ_DEV_HOME/bin
$DBEAVER_HOME/dbeaver -vm $JDK_HOME/bin/java
