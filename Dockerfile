# syntax=docker/dockerfile:1.20.0@sha256:26147acbda4f14c5add9946e2fd2ed543fc402884fd75146bd342a7f6271dc1d
# check=error=true

FROM alpine:3.23.2@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN adduser -D java -u 1005 && apk add --no-cache freetype ncurses wine

ARG JAVA_VERSION="25.0.1-8"

RUN wget -q "https://github.com/adoptium/temurin$(echo "${JAVA_VERSION}" | head -c2)-binaries/releases/download/jdk-$(echo "${JAVA_VERSION}" | sed "s/-/+/g")/OpenJDK$(echo "${JAVA_VERSION}" | head -c2)U-jdk_x64_windows_hotspot_$(echo "${JAVA_VERSION}" | sed "s/-/_/g").zip" -O /tmp/openjdk-windows.zip && \
    unzip /tmp/openjdk-windows.zip -d /tmp && mv "/tmp/jdk-$(echo "${JAVA_VERSION}" | sed "s/-/+/g")" /opt/openjdk-windows && rm /tmp/openjdk-windows.zip && chmod -R ugo+rX /opt/openjdk-windows
COPY java-windows-delegate.sh /usr/bin/java-windows-delegate.sh
RUN chmod +x /usr/bin/java-windows-delegate.sh && \
    ln -s java-windows-delegate.sh /usr/bin/java && \
    ln -s java-windows-delegate.sh /usr/bin/javac && \
    ln -s java-windows-delegate.sh /usr/bin/javadoc && \
    ln -s java-windows-delegate.sh /usr/bin/javap && \
    ln -s java-windows-delegate.sh /usr/bin/jshell

USER java

RUN wineboot

CMD ["jshell"]
