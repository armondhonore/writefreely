# Pinned fix — writefreely (#152)

Deploy the STOCK algernon/writefreely:latest image (writeas/writefreely redirects
here). Its entrypoint auto-generates config.ini, runs migrations, and creates the
admin user from WRITEFREELY_* env vars on first boot. Listens on :8080, data in /data.
DO NOT add a custom Dockerfile, do NOT switch to mysql, do NOT change the port to 80,
do NOT add a PVC. Keep nexlayer.yaml exactly as committed.
