#!/bin/bash

. ambiente.conf

cd $DEV_HOME/bin
$DBEAVER_HOME/dbeaver -vm $JDK_HOME/bin/java
