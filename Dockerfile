# docker inspect --format='{{index .RepoDigests 0}}' debian:buster-slim
FROM debian@sha256:544c93597c784cf68dbe492ef35c00de7f4f6a990955c7144a40b20d86a3475f

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
