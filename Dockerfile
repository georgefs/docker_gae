FROM ubuntu:14.04


# install google appengine sdk
ADD google-cloud-sdk /tmp/google-cloud-sdk
RUN mv tmp/google-cloud-sdk/google-cloud-sdk /etc/google-cloud-sdk

# setup google appengine sdk path
RUN echo 'export PYTHONPATH="/etc/google-cloud-sdk/platform/google_appengine"' >> /etc/bash.bashrc
RUN echo 'export PATH="/etc/google-cloud-sdk/bin:$PATH"' >> /etc/bash.bashrc

### install package

RUN apt-get update

## nginx
RUN apt-get install -y nginx

# setup nginx
ADD nginx_conf /tmp/nginx_conf
RUN mv /tmp/nginx_conf /etc/nginx/sites-enabled/default


# install python env
RUN apt-get install -y python
RUN apt-get install -y python-setuptools
RUN apt-get install -y python-pip

# python - mysql
RUN apt-get install -y python-dev libmysqlclient-dev
RUN pip install MySQL-python

# pil
RUN apt-get install -y libjpeg62 libjpeg62-dev
RUN apt-get install -y libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev
RUN apt-get install -y python-pil

ADD run.sh /bin/run

RUN /etc/google-cloud-sdk/bin/gcloud components update
