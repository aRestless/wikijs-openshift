#!/usr/bin/env bash

oc create configmap wikijs-config --from-file config/config.yml --dry-run -o yaml \
    | oc replace configmap wikijs-config -f -