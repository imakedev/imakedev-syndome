#!/bin/sh
export JAVA_HOME=/usr/local/data/Java/jdk1.7.0_07
#nohup sh thebluecode.sh > /dev/null 2>&1 &
#-Xms128m -Xmx1024m -XX:MaxPermSize=512m
${JAVA_HOME}/bin/java -Xms128m -Xmx1024m -XX:MaxPermSize=512m -cp .:lib/commons-codec-1.6.jar:lib/commons-io-2.4.jar:lib/commons-logging-1.1.1.jar:lib/dbfdriver.jar:lib/log4j-1.2.17.jar:lib/mysql-connector-java-5.1.27-bin.jar:lib/poi-3.9-20121203.jar:lib/poi-ooxml-3.9-20121203.jar:lib/poi-ooxml-schemas-3.9-20121203.jar:lib/ExpressAgent.jar th.co.imake.syndome.agent.ExpressAgent
#${JAVA_HOME}/bin/java -cp .:lib/commons-codec-1.6.jar:lib/commons-io-2.4.jar:lib/commons-logging-1.1.1.jar:lib/fluent-hc-4.2.3.jar:lib/httpclient-4.2.3.jar:lib/httpclient-cache-4.2.3.jar:lib/httpcore-4.2.2.jar:lib/httpmime-4.2.3.jar:lib/json-simple-1.1.1.jar:lib/log4j-1.2.17.jar:lib/mysql-connector-java-5.1.22-bin.jar:lib/thebluecodeAgent.jar th.co.aoe.imake.thebluecode.agent.NumberAgent