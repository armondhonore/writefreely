FROM writeas/writefreely:latest

WORKDIR /go

# Bake a sqlite config and pre-initialize the database + encryption keys at
# build time so the container can serve immediately (the schema has no
# command/entrypoint override, so the image must self-initialize).
COPY config.ini /go/config.ini

RUN mkdir -p /go/data \
 && cmd/writefreely/writefreely -c /go/config.ini --init-db \
 && cmd/writefreely/writefreely -c /go/config.ini --gen-keys \
 && cmd/writefreely/writefreely -c /go/config.ini --create-admin admin:adminpass123

EXPOSE 8080

ENTRYPOINT ["cmd/writefreely/writefreely", "-c", "/go/config.ini"]
