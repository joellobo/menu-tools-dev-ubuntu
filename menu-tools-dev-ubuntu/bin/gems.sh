#!/bin/bash

. ambiente.conf

CLASSPATH=$TIBEMS_HOME/lib/jms-2.0.jar
CLASSPATH=$CLASSPATH:$TIBEMS_HOME/lib/jndi.jar
CLASSPATH=$CLASSPATH:$TIBEMS_HOME/lib/tibjms.jar
CLASSPATH=$CLASSPATH:$TIBEMS_HOME/lib/tibcrypt.jar
CLASSPATH=$CLASSPATH:$TIBEMS_HOME/lib/tibjmsadmin.jar
CLASSPATH=$CLASSPATH:$TIBEMS_HOME/lib/slf4j-api-1.4.2.jar
CLASSPATH=$CLASSPATH:$TIBEMS_HOME/lib/slf4j-simple-1.4.2.jar
CLASSPATH=$CLASSPATH:$TIBGEMS_HOME/Gems.jar
CLASSPATH=$CLASSPATH:$TIBGEMS_HOME/lib/looks-2.3.1.jar
CLASSPATH=$CLASSPATH:$TIBGEMS_HOME/lib/jcommon-1.0.16.jar
CLASSPATH=$CLASSPATH:$TIBGEMS_HOME/lib/jfreechart-1.0.13.jar

cd $TIBGEMS_HOME
$JDK_HOME/bin/java -classpath $CLASSPATH -Xmx128m -DPlastic.defaultTheme=DesertBlue com.tibco.gems.Gems gems.props
