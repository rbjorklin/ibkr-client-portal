FROM docker.io/library/eclipse-temurin:20-jre-alpine

EXPOSE 5000

ENV PACKAGE=clientportal.gw.zip

WORKDIR /client-portal
RUN apk add unzip curl sed

RUN curl -Lo /jolokia-jvm.jar https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.7.1/jolokia-jvm-1.7.1.jar
RUN curl -LO https://download2.interactivebrokers.com/portal/${PACKAGE} &&\
    sha256sum ${PACKAGE} > ${PACKAGE}.sha256 &&\
    unzip ${PACKAGE} &&\
    rm -f ${PACKAGE}
RUN sed -i 's/^\s\{4\}//g' root/conf.yaml &&\
    sed -i 's/allow:/allow:\n    - 10.*\n    - 172.*/g' root/conf.yaml &&\
    sed -i 's&#!/bin/bash&#!/bin/ash&g' bin/run.sh &&\
    sed -i 's#^java#java ${JAVA_OPTS}#g' bin/run.sh &&\
    sed -i "s/#export\ JAVA_HOME=.*/export JAVA_HOME=\/opt\/java\/openjdk/g" bin/run.sh &&\
    sed -i 's/^name=$(basename $config_path)/name=$(basename $config_file)/g' bin/run.sh &&\
    sed -i 's/^--conf.*/--conf $name/g' bin/run.sh

CMD /client-portal/bin/run.sh root/conf.yaml
