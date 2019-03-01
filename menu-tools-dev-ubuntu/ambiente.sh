#!/bin/bash
# SETANDO VARIAVEIS
echo "###############################################"
echo "# SETANDO VARIAVEIS"
SAJ_DIR=~/dev/saj
SAJ_APPS_DIR=$SAJ_DIR/apps
ECLIPSE_URL=http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/2018-09/R/eclipse-jee-2018-09-linux-gtk-x86_64.tar.gz
DBEAVER_URL=https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
SOAPUI_URL=https://s3.amazonaws.com/downloads.eviware/soapuios/5.4.0/SoapUI-x64-5.4.0.sh
JD_URL=https://github.com/java-decompiler/jd-gui/releases/download/v1.4.0/jd-gui-1.4.0.jar
ALM_PLUGIN_URL=http://10.139.3.117/packages/RTC-Client-p2Repo-6.0.4.zip
JBOSS_URL=http://10.139.3.117/packages/jboss-6.4.1-eap.tar.gz
SQLPA_URL=http://www.bestofbi.com/downloads/architect/1.0.8/SQL-Power-Architect-generic-jdbc-1.0.8.tar.gz

echo "###############################################"
echo "# BACKUP ~/DEV/SAJ/APPS-$(date +%Y-%m-%d-%H-%M)"
mv $SAJ_APPS_DIR ~/dev/saj/apps-$(date +%Y-%m-%d-%H-%M)
mkdir -p $SAJ_DIR/apps/packages

echo "###############################################"
echo "# 1. SDKMAN"
if command -v sdk != 0 ; then
	echo "# Instalando sdman"
	curl -s "https://get.sdkman.io" | bash
	source curl -s "https://get.sdkman.io" | bash"$HOME/.sdkman/bin/sdkman-init.sh"
	echo "source \"$HOME/.sdkman/bin/sdkman-init.sh\"" >> ~/.bashrc
	sdk install maven
	sdk install java 8.0.191-oracle
	sdk default java 8.0.191-oracle
fi;

echo "###############################################"
echo "# 2. Instalando Eclipse"
#eclipse java EE
cd $SAJ_APPS_DIR
wget $ECLIPSE_URL -P $SAJ_APPS_DIR
tar zxvf ${ECLIPSE_URL##*/}
mv ${ECLIPSE_URL##*/} packages

cd eclipse
echo "###############################################"
echo "# 3. Instalando Plugins do Eclipse"
echo "###############################################"
echo "# 3.1 SONARLINT"
./eclipse -application org.eclipse.equinox.p2.director -nosplash -repository https://eclipse-uc.sonarlint.org -installIU org.sonarlint.eclipse.feature.feature.group
echo "###############################################"
echo "# 3.2 CHECKSTYLE"
./eclipse -application org.eclipse.equinox.p2.director -nosplash -repository https://checkstyle.org/eclipse-cs/update -installIU net.sf.eclipsecs.feature.group
echo "###############################################"
echo "# 3.3 JBOSS AS"
./eclipse -application org.eclipse.equinox.p2.director -nosplash -repository http://download.jboss.org/jbosstools/photon/stable/updates -installIU org.jboss.ide.eclipse.as.serverAdapter.wtp.feature.feature.group
echo "###############################################"
echo "# 3.4 ALM"
wget $ALM_PLUGIN_URL --no-passive-ftp
set +H
./eclipse -application org.eclipse.equinox.p2.director -nosplash -repository "jar:file:$PWD/RTC-Client-p2Repo-6.0.4.zip!/" -installIU com.ibm.team.rtc.client.feature.feature.group

mv ${ALM_PLUGIN_URL##*/} ../packages

echo "###############################################"
echo "# 4. DBEAVER"
cd $SAJ_APPS_DIR
wget $DBEAVER_URL 
tar zxvf ${DBEAVER_URL##*/}
mv ${DBEAVER_URL##*/} packages

echo "###############################################"
echo "# 5. SOAPUI"
cd $SAJ_APPS_DIR
mkdir -p soapui
wget $SOAPUI_URL 
sh ${SOAPUI_URL##*/} -q -dir $SAJ_APPS_DIR/soapui
mv ${DBEAVER_URL##*/} packages
mv -v ~/popular-apis ~/WSDL-WADL ~/Sample*soapui-project.xml $SAJ_APPS_DIR/soapui

echo "###############################################"
echo "# 6. JBOSS"
cd $SAJ_APPS_DIR
wget $JBOSS_URL --no-passive-ftp
tar zxvf ${JBOSS_URL##*/}
mv ${JBOSS_URL##*/} packages

echo "###############################################"
echo "# 7. JD"
cd $SAJ_APPS_DIR
mkdir -p jd
cd jd
wget $JD_URL

echo "###############################################"
echo "# 8. SQLPOWERARQUITECT"
cd $SAJ_APPS_DIR
wget $SQLPA_URL 
tar zxvf ${SQLPA_URL##*/}
mv ${SQLPA_URL##*/} packages

