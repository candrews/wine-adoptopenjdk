From alpine:3.20.3@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a

RUN apk add --no-cache freetype ncurses wine && wineboot

ARG JAVA_VERSION="21.0.5-11"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN wget -q "https://github.com/adoptium/temurin$(echo "${JAVA_VERSION}" | head -c2)-binaries/releases/download/jdk-$(echo "${JAVA_VERSION}" | sed "s/-/+/g")/OpenJDK$(echo "${JAVA_VERSION}" | head -c2)U-jdk_x64_windows_hotspot_$(echo "${JAVA_VERSION}" | sed "s/-/_/g").zip" -O /tmp/openjdk-windows.zip && \
    unzip /tmp/openjdk-windows.zip -d /tmp && mv "/tmp/jdk-$(echo "${JAVA_VERSION}" | sed "s/-/+/g")" /opt/openjdk-windows && rm /tmp/openjdk-windows.zip
COPY java-windows-delegate.sh /usr/bin/java-windows-delegate.sh
RUN chmod +x /usr/bin/java-windows-delegate.sh && \
    ln -s java-windows-delegate.sh /usr/bin/java && \
    ln -s java-windows-delegate.sh /usr/bin/javac && \
    ln -s java-windows-delegate.sh /usr/bin/javadoc && \
    ln -s java-windows-delegate.sh /usr/bin/javap && \
    ln -s java-windows-delegate.sh /usr/bin/jshell

CMD ["jshell"]
