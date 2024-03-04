#!/bin/bash
set -e
set -x

exec java -Dspring.profiles.active="prod" -jar /var/app/demo-0.0.1-SNAPSHOT.jar