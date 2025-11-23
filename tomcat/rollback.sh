#!/bin/bash
set -e
TOMCAT_HOST=tomcat-server
TOMCAT_USER=deploy
BACKUP_WAR=$1
scp ${BACKUP_WAR} ${TOMCAT_USER}@${TOMCAT_HOST}:/opt/tomcat/webapps/ROOT.war
ssh ${TOMCAT_USER}@${TOMCAT_HOST} "sudo systemctl restart tomcat"
