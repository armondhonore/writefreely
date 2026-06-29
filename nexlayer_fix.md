# Pinned fix — writefreely (#152)

Run the stock algernon writefreely-docker.sh entrypoint as ROOT (USER root) so it can
write config/db/keys into the /data PVC on first boot (non-root user crash-loops on the
root-owned mounted volume; schema has no fsGroup). sqlite, port 8080, PVC at /data.
DO NOT switch to mysql, DO NOT change port to 80, DO NOT remove USER root.
