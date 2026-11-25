#!/bin/sh
mvn -q clean package -DskipTests && java -jar target/totp-authenticator-1.0.0.jar
