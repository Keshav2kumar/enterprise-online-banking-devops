#!/bin/bash
set -e
TOMCAT_HOST=tomcat-server
TOMCAT_USER=deploy
TOMCAT_HOME=/opt/tomcat
WAR_FILE=$1
ssh ${TOMCAT_USER}@${TOMCAT_HOST} "sudo systemctl stop tomcat"
scp ${WAR_FILE} ${TOMCAT_USER}@${TOMCAT_HOST}:${TOMCAT_HOME}/webapps/ROOT.war
ssh ${TOMCAT_USER}@${TOMCAT_HOST} "sudo systemctl start tomcat"
sleep 10
curl -f http://${TOMCAT_HOST}:8080/health || (echo "Tomcat app failed" && exit 1)
