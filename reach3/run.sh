#!/bin/sh -e
FLAGS=${FLAGS:-"-td"}
NETWORK=${NETWORK:-"reach3"}
NAME=${NAME:-"reach.$NETWORK"}
FSNODE=${FSNODE:-"freeswitch@freeswitch.$NETWORK"}
KAMNODE=${KAMNODE:-"kamailio@kamailio.$NETWORK"}
NODE=${NODE:-"reach@$NAME"}
CFG_DB=${CFG_DB:-"`pwd`/db"}

if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
	STAMP=`date +%Y-%m-%d-%H-%M-%S`
	mkdir -p logs
	docker logs $NAME > logs/$STAMP

	echo -n "stopping: "
	docker stop -t 1 $NAME
	echo -n "removing: "
	docker rm -f $NAME
fi

# file must exists
mkdir -p $CFG_DB
touch $CFG_DB/reach_db.json
chmod o+w $CFG_DB/reach_db.json

if [ ! -z $CLEAR_RUNTIME_DB ]
then
	echo > $CFG_DB/reach_db.json
fi

echo -n "starting: $NAME with db: $CFG_DB/reach_db.json "
docker run $FLAGS \
	-v $CFG_DB:/home/user/reach/db \
	--net $NETWORK \
	-h $NAME \
	--restart=always \
	--name $NAME \
	--env NETWORK=$NETWORK \
	--env NODE=$NODE \
	--env FSNODE=$FSNODE \
	--env KAMNODE=$KAMNODE \
	ezuce/reach
