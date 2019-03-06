#!/bin/bash

. ambiente.conf

export PATH=$JDK_HOME/bin:$PATH

cd $DEV_HOME/bin
$SOAPUI_HOME/bin/soapui.sh
