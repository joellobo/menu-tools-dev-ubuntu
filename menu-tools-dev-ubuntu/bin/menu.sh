#!/bin/bash

. ambiente.conf

programa=$(zenity --list \
  --width=400 \
  --height=350 \
  --title="Menu desenvolvedor" \
  --column="Escolha a ferramenta quer executar" --column="Versão atual" \
           "Eclipse"                                     "$ECLIPSE_VERSION" \
           "DBeaver"                                     "$DBEAVER_VERSION" \
           "Sublime"                                     "$SUBLIME_VERSION" \
           "Architect"                                   "$ARCHITECT_VERSION" \
           "Gems"                                        "$TIBGEMS_VERSION" \
           "Ireport"                                     "$IREPORT_VERSION" \
           "JavaDecompiler"                              "$JAVADECOMPILER_VERSION" \
           "SoapUi"                                      "$SOAPUI_VERSION" \
           "VisualVm"                                    "$VISUALVM_VERSION" \
           "FileZilla"                                   "" \
           "Terminal"                                    "" 2> /dev/null)

if [ -z "$programa" ]; then
    exit 0;
fi

case "$programa" in
    Eclipse) ./eclipse.sh &
       ;;
    DBeaver) ./dbeaver.sh &
       ;;
    Sublime) ./sublime.sh &
       ;;
    Architect) ./architect.sh &
       ;;
    Gems) ./gems.sh &
       ;;
    Ireport) ./ireport.sh &
       ;;
    JavaDecompiler) ./javadecompiler.sh &
       ;;
    SoapUi) ./soapui.sh &
       ;;
    VisualVm) ./visualvm.sh &
       ;;
    FileZilla) filezilla &
       ;;
    Terminal) gnome-terminal &
       ;;
    *) echo "Opcao nao disponível!"
       ;;
esac
