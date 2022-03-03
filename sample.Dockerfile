FROM ubuntu:18.04

ARG JDK_PKG=https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
ARG MVN_PKG=https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
ARG AWS_PKG=https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.1.39.zip

WORKDIR /tmp

# Instalar pacotes basicos do ubuntu
RUN apt-get -y update && apt-get install -y wget unzip libapache-poi-java curl \
    && rm -rf /var/lib/apt/lists/*

# Instalar java
RUN wget -cnv $JDK_PKG -O jdk.tar.gz \
    && mkdir /opt/jdk \
    && tar -xvzf jdk.tar.gz -C /opt/jdk --strip-components=1

# Instalar maven
RUN wget -cnv $MVN_PKG -O maven.tar.gz \
    && mkdir /opt/maven \
    && tar -xvzf maven.tar.gz -C /opt/maven --strip-components=1

# Instalar aws
RUN curl $AWS_PKG -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

ENV JAVA_HOME /opt/jdk
ENV M2_HOME /opt/maven
ENV AWS_HOME /usr/local/aws-cli/v2/2.1.39

ENV PATH "$PATH:$JAVA_HOME/bin:$M2_HOME/bin:$AWS_HOME/dist"
ENV LANG              "pt_BR.UTF-8"
ENV LANGUAGE          "pt_BR"
ENV LC_CTYPE          "pt_BR.UTF-8"
ENV LC_NUMERIC        "pt_BR.UTF-8"
ENV LC_TIME           "pt_BR.UTF-8"
ENV LC_COLLATE        "pt_BR.UTF-8"
ENV LC_MONETARY       "pt_BR.UTF-8"
ENV LC_MESSAGES       "pt_BR.UTF-8"
ENV LC_PAPER          "pt_BR.UTF-8"
ENV LC_NAME           "pt_BR.UTF-8"
ENV LC_ADDRESS        "pt_BR.UTF-8"
ENV LC_TELEPHONE      "pt_BR.UTF-8"
ENV LC_MEASUREMENT    "pt_BR.UTF-8"
ENV LC_IDENTIFICATION "pt_BR.UTF-8"

COPY etc/scripts/checkout-app /bin/checkout-app
RUN  chmod +x /bin/checkout-app

COPY etc/scripts/build-app /bin/build-app
RUN  chmod +x /bin/build-app

COPY etc/scripts/test-app /bin/test-app
RUN  chmod +x /bin/test-app

COPY etc/scripts/analyze-app /bin/analyze-app
RUN  chmod +x /bin/analyze-app

COPY etc/scripts/deploy-app /bin/deploy-app
RUN  chmod +x /bin/deploy-app

RUN curl -LOs https://storage.googleapis.com/kubernetes-release/release/v1.19.3/bin/linux/amd64/kubectl \
    && mv -v ./kubectl /bin && chmod +x /bin/kubectl

RUN curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

WORKDIR /app
