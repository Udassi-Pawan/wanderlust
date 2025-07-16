#!/bin/sh

hosts="$1"
port="$2"
shift 2
cmd="$@"


until mongosh --host "$host" --port "$port" --eval 
"db.adminCommand('ping)" >/dev/null
2>&1; do
 >&2 echo "Waiting for MongoDB at $host: $port..."
 sleep 2
 done 


>&2 echo "$host:$port is up -running command"
exec $cmd
