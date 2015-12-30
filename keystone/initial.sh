#!/usr/bin/env bash
openstack service create --name keystone --description "Openstack Identity" identity
openstack endpoint create --region RegionOne identity public http://$(docker-machine ip dev):5000/v2.0
openstack endpoint create --region RegionOne identity internal http://$(docker-machine ip dev):5000/v2.0
openstack endpoint create --region RegionOne identity admin http://$(docker-machine ip dev):35357/v2.0
openstack project create --domain default --description "Admin Project" admin
openstack project create --domain default --description "Demo Project" demo
openstack project create --domain default --description "Service Project" service
openstack user create --domain default --password Braves admin
openstack user create --domain default --password demopass demo
openstack role create admin
openstack role create user
openstack role add --project admin --user admin admin
openstack role add --project demo --user demo user
