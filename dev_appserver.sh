#!/bin/bash

CURRENT_PATH=`pwd`
docker run -i -t --rm=True -v $CURRENT_PATH:/srv/worker -w /srv/worker -p 8080:80 georgefs/gae /bin/run $@
