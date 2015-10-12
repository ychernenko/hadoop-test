#!/usr/bin/env bash

yum -y install passwd java

useradd hadoop
echo hadoop | passwd hadoop --stdin

java -version