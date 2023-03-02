FROM openjdk:21-ea-jdk-slim

# JMeter version
ARG JMETER_VERSION=5.0

# Install few utilities
RUN apt-get update && apt-get install -y \
    curl \
    wget\
 && rm -rf /var/lib/apt/lists/*
 RUN apt-get clean all

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
