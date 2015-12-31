#!/usr/bin/env bash
if openstack user show mistral; then
    exit 0
fi
openstack service create --name keystone --description "Openstack Identity" identity
openstack service create --name mistral --description "Openstack Workflow Service" workflowv2
openstack endpoint create --region RegionOne identity public http://$(docker-machine ip $DOCKER_MACHINE_NAME):5000/v2.0
openstack endpoint create --region RegionOne identity internal http://$(docker-machine ip $DOCKER_MACHINE_NAME):5000/v2.0
openstack endpoint create --region RegionOne identity admin http://$(docker-machine ip $DOCKER_MACHINE_NAME):35357/v2.0
openstack endpoint create --region RegionOne workflowv2 public "http://$(docker-machine ip $DOCKER_MACHINE_NAME):8989/v2"
openstack endpoint create --region RegionOne workflowv2 internal "http://$(docker-machine ip $DOCKER_MACHINE_NAME):8989/v2"
openstack endpoint create --region RegionOne workflowv2 admin "http://$(docker-machine ip $DOCKER_MACHINE_NAME):8989/v2"
openstack project create --domain default --description "Admin Project" admin
openstack project create --domain default --description "Demo Project" demo
openstack project create --domain default --description "Service Project" service
openstack user create --domain default --password Braves admin
openstack user create --domain default --password demopass demo
openstack user create --domain default --password mistralpass mistral
openstack role create admin
openstack role create user
openstack role add --project admin --user admin admin
openstack role add --project demo --user demo user
openstack role add --project service --user mistral admin
