#!/bin/bash

(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

HOST=localhost
PORT=5432
USER=openchpl_dev
FILEPATH=.

while getopts "h:p:u:f:i?" OPTION; do
    case "$OPTION" in
        h)
	    HOST=$OPTARG
            ;;
        p)
            PORT=$OPTARG
            ;;
        u)
            USER=$OPTARG
            ;;
        f)
            FILEPATH=$OPTARG
            ;;
        *) printf 'Usage: %s: [-f path ] [-h host] [-p port] [-u user]
   -f: path of output SQL files (default ".")
   -h: host IP for postgres DB (default "localhost")
   -p: host port for postgres DB (default "5432")
   -u: user performing load (default "openchpl_dev")
   -?: print this message\n' $0; exit 0 ;;
    esac
done

echo "h = $HOST"
echo "p = $PORT"
echo "u = $USER"
echo "f = $FILEPATH"

pg_dump --host $HOST --username $USER --port $PORT --no-password --schema-only -n openchpl -f $FILEPATH/openchpl-ddl.sql openchpl
pg_dump --host $HOST --username $USER --port $PORT --no-password --schema-only -n quartz -f $FILEPATH/quartz-ddl.sql openchpl
pg_dump --host $HOST --username $USER --port $PORT --no-password --schema-only -n ff4j -f $FILEPATH/ff4j-ddl.sql openchpl
