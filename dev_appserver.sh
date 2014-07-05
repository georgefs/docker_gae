#!/bin/bash

CURRENT_PATH=`pwd`
sudo docker run -i -t -v $CURRENT_PATH:/srv/worker -w /srv/worker -p 8080:80 georgefs/gae /bin/run $@
