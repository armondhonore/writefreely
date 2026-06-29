# Pinned fix — writefreely (#152)

DO NOT regenerate the Dockerfile or nexlayer.yaml. Use sqlite, NOT mysql.
The Dockerfile is hand-authored to bake a sqlite config.ini (db at
/go/data/writefreely.db), run --init-db/--gen-keys/--create-admin at build
time, and serve via `cmd/writefreely/writefreely -c /go/config.ini` on :8080.
No PVC. Keep config.ini, Dockerfile, and nexlayer.yaml exactly as committed.
