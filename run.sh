#!/usr/bin/env bash
# Run java application

java \
    -Xmx${XMX} -XX:+IdleTuningGcOnIdle -Xtune:virtualized -Xscmx128m -Xscmaxaot100m -Xshareclasses:cacheDir=/opt/shareclasses \
    -jar eureka-discovery.jar \
    --server.port=${SERVER_PORT} \
    --eureka.instance.preferIpAddress=${REGISTER_WITH_IP} \
/