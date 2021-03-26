From alpine:3.13.3@sha256:826f70e0ac33e99a72cf20fb0571245a8fee52d68cb26d8bc58e53bfa65dcdfa

# renovate: datasource=repology depName=alpine_3_13/freetype versioning=loose
ENV FREETYPE_VERSION="2.10.4-r1"

# renovate: datasource=repology depName=alpine_3_13/ncurses versioning=loose
ENV NCURSES_VERSION="6.2_p20210109-r0"

# renovate: datasource=repology depName=alpine_3_13/wine versioning=loose
ENV WINE_VERSION="4.0.3-r0"

RUN apk add --no-cache freetype="${FREETYPE_VERSION}" ncurses="${NCURSES_VERSION}" wine="${WINE_VERSION}" && wineboot

ENV JAVA_VERSION="15.0.2+7"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN wget "https://github.com/AdoptOpenJDK/openjdk$(echo "${JAVA_VERSION}" | head -c2)-binaries/releases/download/jdk-${JAVA_VERSION}/OpenJDK$(echo "${JAVA_VERSION}" | head -c2)U-jdk_x64_windows_hotspot_$(echo "${JAVA_VERSION}" | sed "s/+/_/g").zip" -O /tmp/openjdk-windows.zip && \
    unzip /tmp/openjdk-windows.zip -d /tmp && mv "/tmp/jdk-${JAVA_VERSION}" /opt/openjdk-windows && rm /tmp/openjdk-windows.zip
COPY java-windows-delegate.sh /usr/bin/java-windows-delegate.sh
RUN chmod +x /usr/bin/java-windows-delegate.sh && \
    ln -s java-windows-delegate.sh /usr/bin/java && \
    ln -s java-windows-delegate.sh /usr/bin/javac && \
    ln -s java-windows-delegate.sh /usr/bin/javadoc && \
    ln -s java-windows-delegate.sh /usr/bin/javap && \
    ln -s java-windows-delegate.sh /usr/bin/jshell
CMD ["jshell"]
