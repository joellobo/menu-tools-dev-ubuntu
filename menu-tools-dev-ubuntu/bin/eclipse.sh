#!/bin/bash

. ambiente.conf

CAMINHO_RECENT_WORKSPACES=../apps/eclipse/$ECLIPSE_VERSION/configuration/.settings/org.eclipse.ui.ide.prefs

if [ $# -eq 0 ]; then
    cd $SAJ_DEV_HOME/bin
    $ECLIPSE_HOME/eclipse -vm $JDK_HOME/bin/java
elif [ "$1" = "clean" ]; then
    if [ ! -f $CAMINHO_RECENT_WORKSPACES ]; then
        echo "Arquivo não encontrado: $CAMINHO_RECENT_WORKSPACES"
    else
        sed -i.bkp "s,^RECENT_WORKSPACES=.*,RECENT_WORKSPACES=$HOME/dev/saj/workspaces/novointegra-des," $CAMINHO_RECENT_WORKSPACES
    fi
fi
