FROM openjdk:8-jdk-alpine as builder

RUN mkdir -p /gradle

ADD  build.gradle /gradle
ADD  settings.gradle /gradle
ADD  src /gradle/src
ADD  gradlew /gradle
ADD  gradle /gradle/gradle
WORKDIR /gradle
RUN ./gradlew build

FROM adoptopenjdk/openjdk8-openj9:x86_64-alpine-jdk8u181-b13_openj9-0.9.0-slim

ENV SERVER_PORT 8761
ENV XMX 128m


RUN mkdir -p /app
COPY --from=builder /gradle/build/libs/eureka-discovery.jar /app/

CMD ["java", \
    "-Xmx${XMX}", "-XX:+IdleTuningGcOnIdle", "-Xtune:virtualized", "-Xscmx128m", "-Xscmaxaot100m", "-Xshareclasses:cacheDir=/opt/shareclasses", \
    "-jar", "eureka-discovery.jar", \
    "--server.port=${SERVER_PORT}" \
]