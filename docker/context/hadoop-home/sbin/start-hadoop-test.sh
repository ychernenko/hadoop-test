#!/usr/bin/env bash
service sshd start &&
start-dfs.sh &&
start-yarn.sh &&
mr-jobhistory-daemon.sh start historyserver