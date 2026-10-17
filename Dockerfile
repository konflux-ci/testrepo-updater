# Red Hat Hardened Image — minimal glibc runtime (Project Hummingbird), digest-pinned
FROM registry.access.redhat.com/hi/core-runtime@sha256:dde95dd9acc448a70565d2cd3d0bc384f8c2640bfd1dece6c89a6f0193e2b7fc

COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
