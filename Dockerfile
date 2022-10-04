From alpine:3.13.5@sha256:1d30d1ba3cb90962067e9b29491fbd56997979d54376f23f01448b5c5cd8b462

# renovate: datasource=repology depName=alpine_3_13/freetype versioning=loose
ARG FREETYPE_VERSION="2.10.4-r3"

# renovate: datasource=repology depName=alpine_3_13/ncurses versioning=loose
ARG NCURSES_VERSION="6.2_p20210109-r1"

# renovate: datasource=repology depName=alpine_3_13/wine versioning=loose
ARG WINE_VERSION="4.0.3-r0"

RUN apk add --no-cache freetype="${FREETYPE_VERSION}" ncurses="${NCURSES_VERSION}" wine="${WINE_VERSION}" && wineboot

# renovate: datasource=adoptium-java depName=java
ARG JAVA_VERSION="17.0.4.1+1"

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
