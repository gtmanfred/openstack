FROM centos

EXPOSE 8989

ENV PATH /usr/pgsql-9.4/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
CMD mistral-server --server api,engine,executor --config-file /etc/mistral.conf
ADD mistral.conf /etc/mistral.conf
RUN useradd -m mistral

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
RUN yum install -y python-devel python-pip libffi-devel libxslt-devel libxml2-devel libyaml-devel openssl-devel gcc git postgresql94-devel

RUN git clone https://github.com/openstack/mistral.git /mistral
RUN pip install psycopg2
RUN pip install -r /mistral/requirements.txt
RUN pip install -e /mistral

USER mistral
WORKDIR /home/mistral
