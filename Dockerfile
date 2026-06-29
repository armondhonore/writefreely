FROM algernon/writefreely:latest

# Run the stock self-initializing entrypoint (writefreely-docker.sh) as ROOT so it
# can write config + sqlite db + keys into /data on first boot. The image normally
# runs as the non-root "writefreely" user, which cannot write a root-owned mounted
# /data (the schema offers no fsGroup), causing a crash-loop. Root can.
USER root
EXPOSE 8080
ENTRYPOINT ["/writefreely/writefreely-docker.sh"]
