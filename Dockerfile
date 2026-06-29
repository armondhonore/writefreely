FROM writeas/writefreely:latest

WORKDIR /go

# Bake a sqlite config and pre-initialize the database + encryption keys at
# build time so the container can serve immediately (the schema has no
# command/entrypoint override, so the image must self-initialize).
#
# The upstream image runs as USER daemon, so all baked state (db + keys) is
# placed under /go/data (NOT the /go/keys VOLUME, whose build-time writes are
# discarded) and chowned to daemon so the runtime user can read/write it.
COPY config.ini /go/config.ini

USER root
RUN mkdir -p /go/data /go/data/keys \
 && cmd/writefreely/writefreely -c /go/config.ini --init-db \
 && cmd/writefreely/writefreely -c /go/config.ini --gen-keys \
 && cmd/writefreely/writefreely -c /go/config.ini --create-admin admin:adminpass123 \
 && chown -R daemon:daemon /go/data /go/config.ini

USER daemon

EXPOSE 8080

ENTRYPOINT ["cmd/writefreely/writefreely", "-c", "/go/config.ini"]
