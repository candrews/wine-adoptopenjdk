From alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad

# renovate: datasource=repology depName=alpine_3_16/ncurses versioning=loose
ENV NCURSES_VERSION="6.3_p20220521-r0"

# renovate: datasource=repology depName=alpine_3_16/wine versioning=loose
ENV WINE_VERSION="7.8-r0"

RUN apk add --no-cache ncurses="${NCURSES_VERSION}" wine="${WINE_VERSION}" && wineboot


ENV JAVA_VERSION="17.0.4.1+1"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN wget -q "https://github.com/adoptium/temurin$(echo "${JAVA_VERSION}" | head -c2)-binaries/releases/download/jdk-${JAVA_VERSION}/OpenJDK$(echo "${JAVA_VERSION}" | head -c2)U-jdk_x64_windows_hotspot_$(echo "${JAVA_VERSION}" | sed "s/+/_/g").zip" -O /tmp/openjdk-windows.zip && \
    unzip /tmp/openjdk-windows.zip -d /tmp && mv "/tmp/jdk-${JAVA_VERSION}" /opt/openjdk-windows && rm /tmp/openjdk-windows.zip
COPY java-windows-delegate.sh /usr/bin/java-windows-delegate.sh
RUN chmod +x /usr/bin/java-windows-delegate.sh && \
    ln -s java-windows-delegate.sh /usr/bin/java && \
    ln -s java-windows-delegate.sh /usr/bin/javac && \
    ln -s java-windows-delegate.sh /usr/bin/javadoc && \
    ln -s java-windows-delegate.sh /usr/bin/javap && \
    ln -s java-windows-delegate.sh /usr/bin/jshell

CMD ["jshell"]
