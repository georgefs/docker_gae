#!/bin/bash
/etc/init.d/nginx restart

/etc/google-cloud-sdk/platform/google_appengine/dev_appserver.py $@
