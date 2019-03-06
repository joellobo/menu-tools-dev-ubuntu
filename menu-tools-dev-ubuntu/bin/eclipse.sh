#!/bin/bash

. ambiente.conf

CAMINHO_RECENT_WORKSPACES=../apps/eclipse/$ECLIPSE_VERSION/configuration/.settings/org.eclipse.ui.ide.prefs

cd $DEV_HOME/bin
$ECLIPSE_HOME/eclipse -vm $JDK_HOME/bin/java

