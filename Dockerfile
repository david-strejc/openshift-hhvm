FROM debian:jessie

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y hhvm && \
    rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/hhvm/php.ini

# Run scripts
ADD scripts/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

# The app
ADD app /app

# The exposed port
EXPOSE 9000

# VOLUME /app
WORKDIR /app

ENTRYPOINT ["/scripts/run.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Debian linux based HHVM Container" \
      io.k8s.display-name="debian hhvm" \
      io.openshift.expose-services="9000:http" \
      io.openshift.tags="builder,html,hhvm,php" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
