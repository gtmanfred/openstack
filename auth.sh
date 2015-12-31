#!/usr/bin/env bash
admin_url(){
    if [[ -n $OLDCLIENT ]]; then
        echo export OS_AUTH_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):35357/v2.0"
    else
        echo export OS_AUTH_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):35357/v3"
    fi
}
keystone_url(){
    if [[ -n $OLDCLIENT ]]; then
        echo export OS_SERVICE_ENDPOINT="http://$(docker-machine ip $DOCKER_MACHINE_NAME):35357/v2.0"
    else
        echo export OS_SERVICE_ENDPOINT="http://$(docker-machine ip $DOCKER_MACHINE_NAME):35357/v3"
    fi
}
user_url() {
    if [[ -n $OLDCLIENT ]]; then
        echo export OS_AUTH_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5000/v2.0"
    else
        echo export OS_AUTH_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5000/v3"
    fi
}
demo() {
    echo export OS_PROJECT_DOMAIN_ID=default \
                OS_USER_DOMAIN_ID=default \
                OS_PROJECT_NAME=demo \
                OS_TENANT_NAME=demo \
                OS_USERNAME=demo \
                OS_AUTH_TYPE=password \
                OS_PASSWORD=demopass \
                OS_IDENTITY_API_VERSION=3
    user_url
}
admin() {
    echo export OS_PROJECT_DOMAIN_ID=default \
                OS_USER_DOMAIN_ID=default \
                OS_PROJECT_NAME=admin \
                OS_TENANT_NAME=admin \
                OS_USERNAME=admin \
                OS_AUTH_TYPE=password \
                OS_PASSWORD=Braves \
                OS_IDENTITY_API_VERSION=3
    admin_url
}
mistral() {
    echo export OS_PROJECT_DOMAIN_ID=default \
                OS_USER_DOMAIN_ID=default \
                OS_PROJECT_NAME=service \
                OS_USERNAME=mistral \
                OS_TENANT_NAME=mistral \
                OS_AUTH_TYPE=password \
                OS_PASSWORD=mistralpass \
                OS_IDENTITY_API_VERSION=3
    admin_url
}
keystone() {
    echo export OS_TOKEN=99bfa3ca9193f2e671c1 \
                OS_IDENTITY_API_VERSION=3 \
                OS_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):35357/v3" \
                OS_SERVICE_TOKEN=99bfa3ca9193f2e671c1
    keystone_url
}

echo unset OS_TOKEN OS_URL OS_IDENTITY_API_VERSION \
           OS_PROJECT_DOMAIN_ID OS_USER_DOMAIN_ID \
           OS_PROJECT_NAME OS_USERNAME OS_AUTH_TYPE \
           OS_PASSWORD OS_AUTH_URL OS_SERVICE_TOKEN \
           OS_SERVICE_ENDPOINT OS_TENANT_NAME

if [[ -z $1 ]]; then
    exit 0
fi
action=$1
shift 1
while (( $# )); do
    case $1 in 
        oldclient)
            export OLDCLIENT=1
            shift 1
            ;;
        *)
            echo "unknown option"
            exit 1
            ;;
    esac
done
"$action"
