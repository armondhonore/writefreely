# Nexlayer — writefreely

<!-- nexlayer:meta version=1 analyzed=2026-06-30T22:23:48Z repo=https://github.com/armondhonore/writefreely branch=nexlayer -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
WriteFreely is a federated blogging platform designed for simplicity and privacy, allowing users to publish content without tracking or complex social features.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Go | language | latest | Dockerfile |
| SQLite | database | latest | Dockerfile |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- Dockerfile — Container definition utilizing the writefreely-docker.sh entrypoint
- nexlayer.yaml — Platform deployment configuration
- nexlayer.skills — Skill definitions for the Nexlayer environment
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
_No external services detected._
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Docker

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
WRITEFREELY_DB_PATH=/data/writefreely.db
```

### Steps

1. `docker build -t writefreely-local .` — Build the local image
2. `docker run -p 8080:8080 -v $(pwd)/data:/data writefreely-local` — Start the blogging platform

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `WRITEFREELY_SITE_NAME` | `WriteFreely` | plain |
| `app` | `WRITEFREELY_SINGLE_USER` | `"false"` | plain |
| `app` | `WRITEFREELY_OPEN_REGISTRATION` | `"true"` | plain |
| `app` | `WRITEFREELY_ADMIN_USER` | `admin` | plain |
| `app` | `WRITEFREELY_ADMIN_PASSWORD` | _(set via Nexlayer dashboard)_ | secret |
| `writefreely-data` | `mountPath` | `/data` | plain |
| `writefreely-data` | `size` | `5Gi` | plain |

### Secrets Required

Set these in the Nexlayer dashboard before deploying:

- `WRITEFREELY_ADMIN_PASSWORD` (`app` pod)

### nexlayer.yaml

```yaml
application:
  name: writefreely
  pods:
  - name: app
    image: registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/writefreely:19f15655b5d
    path: /
    servicePorts:
    - 8080
    vars:
      WRITEFREELY_SITE_NAME: WriteFreely
      WRITEFREELY_SINGLE_USER: "false"
      WRITEFREELY_OPEN_REGISTRATION: "true"
      WRITEFREELY_ADMIN_USER: admin
      WRITEFREELY_ADMIN_PASSWORD: adminpass123
    volumes:
    - name: writefreely-data
      mountPath: /data
      size: 5Gi
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| writefreely | mirror.gcr.io/library/algernon/writefreely:latest | 8080 | web |

### Deployment notes

- The application uses an embedded SQLite database stored in /data; per Nexlayer rules, if migrated to a client-server DB (Postgres/MySQL), it must be moved to a separate pod.
- The Dockerfile explicitly sets USER root to ensure the entrypoint can initialize the /data volume permissions on the cluster filesystem.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-30T22:24:15Z  
**Live URL:** https://relaxed-weasel-writefreely.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: writefreely
  pods:
  - name: app
    image: registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/writefreely:19f15655b5d
    path: /
    servicePorts:
    - 8080
    vars:
      WRITEFREELY_SITE_NAME: WriteFreely
      WRITEFREELY_SINGLE_USER: "false"
      WRITEFREELY_OPEN_REGISTRATION: "true"
      WRITEFREELY_ADMIN_USER: admin
      WRITEFREELY_ADMIN_PASSWORD: adminpass123
    volumes:
    - name: writefreely-data
      mountPath: /data
      size: 5Gi
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-30T22:23:48Z | analyzed | initial repo analysis |
| 2026-06-30T22:24:15Z | success | deployed https://relaxed-weasel-writefreely.cloud.nexlayer.ai |
<!-- nexlayer:end -->
