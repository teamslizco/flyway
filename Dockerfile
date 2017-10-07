FROM alpine:3.5
MAINTAINER "Team Slizco" <teamslizco@gmail.com>

RUN apk add --no-cache bash wget ca-certificates openjdk8-jre postgresql
RUN set -ex \
  && wget -qO /tmp/flyway-commandline-4.0.3-linux-x64.tar.gz \
      https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0.3/flyway-commandline-4.0.3-linux-x64.tar.gz \
  && mkdir -p /opt/flyway/ \
  && tar -xzf /tmp/flyway-commandline-4.0.3-linux-x64.tar.gz \
      --exclude=flyway-4.0.3/jre \
      -C /opt/flyway

COPY pg_wait /usr/local/bin/

ENV PATH /opt/flyway/flyway-4.0.3:$PATH

VOLUME /flyway

ENTRYPOINT ["pg_wait", "flyway", "-configFile=/flyway/flyway.conf"]
