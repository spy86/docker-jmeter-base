FROM openjdk:18.0.2-slim

# JMeter version
ARG JMETER_VERSION=5.0

# Install few utilities
RUN set -eux; \
        microdnf install \
                gzip \
                wget \
                telnet \
                unzip \
                iputils \
                ; \
        microdnf clean all

# Install JMeter
RUN   mkdir /jmeter \
      && cd /jmeter/ \
      && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
      && tar -xzf apache-jmeter-$JMETER_VERSION.tgz \
      && rm apache-jmeter-$JMETER_VERSION.tgz

# ADD all the plugins
ADD /lib /jmeter/apache-jmeter-$JMETER_VERSION/lib

# ADD the sample test
ADD sample-test sample-test

# Set JMeter Home
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/

# Add JMeter to the Path
ENV PATH $JMETER_HOME/bin:$PATH
