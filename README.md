# wikijs-openshift


A "batteries included" OpenShift deployment for [wikijs](https://wiki.js.org/), deploying the latest version of the
official container alongside a MongoDB.

## Quick Start

You need access to an OpenShift project and need to be able to create two volumes.

Make sure you are logged in to your OpenShift cluster using `oc login` and on the correct project.

Edit the contents of `config/config.yml`. Leave the all environment variables (`$(...)`) untouched, as they will
be replaced by the deployment. You can also still edit everything in the config file later on.

```
ADMIN_EMAIL=yourmailhere@example.org bash scripts/deploy.sh
bash scripts/build.sh
```

This will create a local admin account with the password "admin123". Make sure to change that immediately.

## Additional Parameters

These are all parameters to `deploy.sh` with their default values:

```
ADMIN_EMAIL=yourmailhere@example.org \
    HOST=wikijs-projectname.apps.youropenshiftcluster.com \
    LETSENCRYPT_ENABLED=false \
    bash scripts/deploy.sh
```

### ADMIN_EMAIL

Used for the local admin account.

### HOST

By default this is the route OpenShift automatically creates. If you want to use a more convenient URL, such as
`wiki.example.org`, you can set the variable (omit the protocol). This will also automatically create an according
OpenShift route.

### LETSENCRYPT_ENABLED

This is a little convenience parameter to be used in conjunction with `HOST` for
https://github.com/tnozicka/openshift-acme. By setting it to `true` the route annotation `kubernetes.io/tls-acme` will
be set, leading to openshift-acme, if it is installed, to automatically retrieve a Letsencrypt certificate for that
route.

## Editing the Config

The deploy script will create a config map named "wikijs-config" with the contents of `config.yml`. You can either edit
the config map directly through OpenShift's web UI, or edit the YML file and run `bash update_config.sh`. Both will
trigger an automatic redeploy with the updated config.

## ToDo

Make the second storage volume (wikijs-data) optional, in case users want to use the git-based storage mechanism that
wikijs usually relies upon. Contributions welcome.

## Acknowledgements

https://github.com/dexterfung/wikijs-openshift is a project similar to this repository but requires more manual
configuration. It was very useful while setting up this solution.