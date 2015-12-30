FROM centos

EXPOSE 35357
EXPOSE 5000

ENV PATH /usr/pgsql-9.4/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
CMD /usr/sbin/httpd -DFOREGROUND
ADD keystone.conf /etc/keystone/keystone.conf
RUN useradd -m keystone

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
RUN rpm -Uvh https://repos.fedorapeople.org/repos/openstack/openstack-liberty/rdo-release-liberty-2.noarch.rpm
RUN yum install -y openstack-keystone python-psycopg2.x86_64 httpd mod_wsgi python-memcached

RUN mkdir -p /var/log/keystone /etc/keystone/ssl
RUN keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
RUN chown -R keystone:keystone /var/log/keystone
RUN chown -R keystone:keystone /etc/keystone/ssl
RUN chmod -R o-rwx /etc/keystone/ssl

ADD 20-servername.conf /etc/httpd/conf.d/20-servername.conf
ADD 30-wsgi-keystone.conf /etc/httpd/conf.d/30-wsgi-keystone.conf
