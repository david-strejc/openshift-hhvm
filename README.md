# openshift-hhvm

Template for running hhvm on a container based on debian linux/openshift/docker.

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project (change to your whishes) or add this to your existing project

```sh
oc new-project openshift-hhvm \
    --description="WebServer - HHVM" \
    --display-name="HHVM"
```

Deploy (externally)

```sh
oc new-app https://github.com/weepee-org/openshift-hhvm.git --name hhvm
```

Deploy (weepee internally)
add to Your buildconfig
```yaml
spec:
  strategy:
    dockerStrategy:
      from:
        kind: ImageStreamTag
        name: hhvm-webserver:latest
        namespace: weepee-registry
    type: Docker
```
use in your Dockerfile
```sh
FROM weepee-registry/hhvm-webserver

# Your app
ADD app /app
```

#### Route.yml

Create route for development and testing

```sh
curl https://raw.githubusercontent.com/ure/openshift-hhvm/master/Route.yaml | oc create -f -
```
