# Pinned fix — writefreely (#152)

Custom image FROM algernon/writefreely bakes a fully-initialized sqlite data dir at
/app-data (config + db + keys + admin) as root, chowns it to the writefreely runtime
user, serves on :8080. NO PVC, NO mysql, NO port 80, NO /data volume mount (the
inherited /data VOLUME discards build-time writes — that is why /app-data is used).
DO NOT regenerate the Dockerfile or nexlayer.yaml.
