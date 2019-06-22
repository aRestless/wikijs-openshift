#!/usr/bin/env bash

if [[ ! -f config/config.yml ]]; then
    echo "Copy config/default.yml to config/config.yml and adjust values for your installation."
    exit
fi

if [[ -z "${ADMIN_EMAIL}" ]]; then
	echo "ADMIN_EMAIL must be set."
	exit
fi

HOST=${HOST:-}
LETSENCRYPT_ENABLED=${LETSENCRYPT_ENABLED:-false}

function create() {
    oc process -f $1 --ignore-unknown-parameters \
	    WIKI_ADMIN_EMAIL="${ADMIN_EMAIL}" \
	    HOST="${HOST}" \
	    LETSENCRYPT_ENABLED="${LETSENCRYPT_ENABLED}" \
	    | oc create -f -
}

oc create configmap wikijs-config --from-file config/config.yml

create secrets.yml
create mongodb.yml
create wikijs.yml
create route.yml

if [[ -z "${HOST}" ]]; then
    HOST=$(oc get route wikijs | awk '/wikijs.*/ {print $2}')
    oc set env dc/wikijs WIKIJS_HOST="https://${HOST}"
fi
