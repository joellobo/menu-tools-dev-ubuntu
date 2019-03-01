#!/bin/bash

. ambiente.conf

export PATH=$JDK_HOME/bin:$PATH

cd $SAJ_DEV_HOME/bin
$SOAPUI_HOME/bin/soapui.sh
