FROM algernon/writefreely:latest

# The algernon image runs as USER writefreely:writefreely and self-inits into its
# /data VOLUME on first boot. On this platform /data is provided root-owned and the
# schema offers no fsGroup/securityContext, so the non-root entrypoint cannot write
# it and the container crash-loops. Fix: bake a fully-initialized data dir at
# /app-data (NOT the inherited /data VOLUME, whose build-time writes are discarded)
# as root, chown to the runtime user, run with NO PVC.
USER root
COPY config.ini /app-data/config.ini
RUN mkdir -p /app-data/keys \
 && /writefreely/writefreely -c /app-data/config.ini --init-db \
 && /writefreely/writefreely -c /app-data/config.ini --gen-keys \
 && /writefreely/writefreely -c /app-data/config.ini --create-admin admin:adminpass123 \
 && chown -R writefreely:writefreely /app-data

USER writefreely
WORKDIR /writefreely
EXPOSE 8080
ENTRYPOINT ["/writefreely/writefreely", "-c", "/app-data/config.ini"]
