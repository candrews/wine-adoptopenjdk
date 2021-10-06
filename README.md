# OpenJDK running in Wine

Dockerfile to run OpenJDK from [Adoptium](https://adoptium.net/) in Wine. This approach may sound strange at first, but it is actually quite useful for testing Java applications on Windows or running Java applications that can only run in Windows.

Note that this solution cannot run GUI applications.

## How to use this image

You can run a Java application by using the Wine OpenJDK image directly, passing a java command to docker run:

```sh
$ docker run -it --rm --name my-jar -v "$(pwd)":/usr/myjar -w /usr/myjar craigandrews/wine-adoptopenjdk:latest java -jar my.jar
```

The image contains these convenient commands:
* `java`
* `javac`
* `javadoc`
* `javap`
* `jshell` (which is the default command)

The `JAVA_HOME` environment variable is set the Windows AdoptOpenJDK path.

## Building local Docker image (optional)

This is a base image that you can extend, so it has the bare minimum packages needed. If you add custom package(s) to the Dockerfile, then you can build your local Docker image like this:

```sh
$ docker build --tag my_local_wine-adoptopenjdk:latest .
```
