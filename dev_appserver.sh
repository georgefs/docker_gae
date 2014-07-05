#!/bin/bash


KERNEL=`uname`
CURRENT_PATH=`pwd`

CONTAINER_PORT=80
HOST_PORT=8080

IMAGE=georgefs/gae

HOST_FOLDER=$HOME/.boot2docker/shared
CONTAINER_FOLDER=/tmp/shared

HASH=`echo $CURRENT_PATH|md5sum|awk '{print $1}'`

LINK_FOLDER=$HOST_FOLDER/$HASH


## check os
if [[ "$KERNEL" == 'Linux' ]]; then
    which docker || exit 1
    SYNC_PATH=$CURRENT_PATH

else
    which boot2docker && which sshfs || exit 1
    test ~/.boot2docker/b2d-passwd || echo 'tcuser' > ~/.boot2docker/b2d-passwd
    
    
    # check vm folder
    boot2docker ssh test $CONTAINER_FOLDER || mkdir $CONTAINER_FOLDER && chmod -R docker:docker $CONTAINER_FOLDER

    test $HOST_FOLDER || sshfs docker@localhost:/tmp/share $HOST_FOLDER -oping_diskarb,volname=share -p 2022 -o reconnect -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o password_stdin < ~/.boot2docker/b2d-passwd

    test $LINK_FOLDER || ln -s $CURRENT_PATH $LINK_FOLDER
    SYNC_PATH=$CONTAINER_FOLDER/$HASH
fi

docker run -i -t -v $SYNC_PATH:/srv/worker -w /srv/worker -p $HOST_PORT:$CONTAINER_PORT $IMAGE /bin/run $@

