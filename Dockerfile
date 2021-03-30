# docker inspect --format='{{index .RepoDigests 0}}' debian:buster-slim
FROM debian@sha256:ca9003e9899b458d46b6ee6b040cf9e0d715acbc58e0615871f019c38ada8bc1

RUN set -uex; \
    apt-get update -y; \
    apt-get install apt-cacher-ng -y --no-install-recommends; \
    mv /etc/apt-cacher-ng/acng.conf /etc/apt-cacher-ng/acng.conf.original; \
    ln -sf /dev/stdout /var/log/apt-cacher-ng/apt-cacher.log; \
    ln -sf /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err; \
    apt-get clean all; \
    rm -rf /var/lib/apt/lists/*;

COPY files/* /etc/apt-cacher-ng/

EXPOSE 3142
VOLUME ["/var/cache/apt-cacher-ng"]

ENTRYPOINT ["/usr/sbin/apt-cacher-ng"]
CMD ["-c","/etc/apt-cacher-ng"]
