ARG SONAR_SCANNER_HOME=/opt/sonar-scanner
ARG NODEJS_HOME=/opt/nodejs

FROM openjdk:11.0.2-jre-slim-stretch AS base
RUN apt-get update \
    && apt-get install -y --no-install-recommends git  wget \
    && rm -rf /var/lib/apt/lists/*

ARG SONAR_SCANNER_HOME
ARG NODEJS_HOME

ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME} \
    SONAR_SCANNER_VERSION=4.3.0.2102 \
    NODEJS_HOME=${NODEJS_HOME} \
    NODEJS_VERSION=v8.17.0 \
    PATH=${PATH}:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin \
    NODE_PATH=${NODEJS_HOME}/lib/node_modules

WORKDIR /opt

RUN wget -U "scannercli" -q -O sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && unzip sonar-scanner-cli.zip \
    && rm sonar-scanner-cli.zip \
    && mv sonar-scanner-${SONAR_SCANNER_VERSION} ${SONAR_SCANNER_HOME}

RUN wget -U "nodejs" -q -O nodejs.tar.xz https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz \
    && tar Jxf nodejs.tar.xz \
    && rm nodejs.tar.xz \
    && mv node-${NODEJS_VERSION}-linux-x64 ${NODEJS_HOME} \
    && npm install -g typescript

COPY scripts /usr/bin/
RUN chmod 755 /usr/bin/run.sh



FROM scratch AS bb-pipe

ARG SONAR_SCANNER_HOME
ARG NODEJS_HOME

ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME} \
    NODEJS_HOME=${NODEJS_HOME} \
    PATH=${PATH}:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin

COPY --from=base / /

WORKDIR /opt

ENTRYPOINT ["/usr/bin/run.sh"]


FROM scratch AS cci-orb

ARG SONAR_SCANNER_HOME
ARG NODEJS_HOME

ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME} \
    NODEJS_HOME=${NODEJS_HOME} \
    PATH=${PATH}:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin

COPY --from=base / /

WORKDIR /opt

