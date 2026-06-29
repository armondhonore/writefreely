# Nexlayer — writefreely

<!-- nexlayer:meta version=1 analyzed=2026-06-29T20:18:04Z repo=https://github.com/armondhonore/writefreely branch=nexlayer -->

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
WriteFreely is an open-source, federated blogging platform that allows users to create and maintain their own blogs with a focus on simplicity and privacy.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Go | language | latest | Dockerfile |
| MySQL | database | latest | WriteFreely documentation |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- Dockerfile — Container definition for the WriteFreely application
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
_No external services detected._
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Go
- MySQL

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
DATABASE_URL=mysql://user:pass@localhost:3306/writefreely
```

### Steps

1. `go build` — Compile the WriteFreely binary
2. `./writefreely` — Start the server on http://localhost:8080

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `DATABASE_URL` | `"mysql://writefreely:${MYSQL_PASSWORD}@mysql.pod:3306/writefreely?parseTime=true"` | inter-pod |
| `app` | `WRITEFREELY_DB_USER` | `writefreely` | plain |
| `app` | `WRITEFREELY_DB_NAME` | `writefreely` | plain |
| `writefreely-app-data` | `size` | `5Gi` | plain |
| `writefreely-app-data` | `mountPath` | `/var/www/writefreely` | plain |
| `mysql` | `MYSQL_DATABASE` | `writefreely` | plain |
| `mysql` | `MYSQL_USER` | `writefreely` | plain |
| `mysql` | `MYSQL_PASSWORD` | `${MYSQL_PASSWORD}` | inter-pod |
| `mysql` | `MYSQL_ROOT_PASSWORD` | `${MYSQL_ROOT_PASSWORD}` | inter-pod |
| `writefreely-mysql-data` | `size` | `10Gi` | plain |
| `writefreely-mysql-data` | `mountPath` | `/var/lib/mysql` | plain |

### nexlayer.yaml

```yaml
application:
  name: writefreely
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/writefreely:19f1507ea1b"
      path: /
      servicePorts:
        - 80
      vars:
        DATABASE_URL: "mysql://writefreely:${MYSQL_PASSWORD}@mysql.pod:3306/writefreely?parseTime=true"
        WRITEFREELY_DB_USER: writefreely
        WRITEFREELY_DB_NAME: writefreely
      volumes:
        - name: writefreely-app-data
          size: 5Gi
          mountPath: /var/www/writefreely
    - name: mysql
      image: mirror.gcr.io/library/mysql:8
      servicePorts:
        - 3306
      vars:
        MYSQL_DATABASE: writefreely
        MYSQL_USER: writefreely
        MYSQL_PASSWORD: ${MYSQL_PASSWORD}
        MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      volumes:
        - name: writefreely-mysql-data
          size: 10Gi
          mountPath: /var/lib/mysql
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| writefreely | mirror.gcr.io/library/writeas/writefreely:latest | 8080 | web |
| db | mirror.gcr.io/library/mysql:8.0 | 3306 | database |

### Deployment notes

- Application connects to the MySQL pod via db.pod:3306 following Nexlayer inter-pod communication rules.
- The image writeas/writefreely is mapped to mirror.gcr.io to comply with Docker Hub namespace restrictions.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-29T20:23:50Z  
**Live URL:** https://relaxed-weasel-writefreely.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: writefreely
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/writefreely:19f1507ea1b"
      path: /
      servicePorts:
        - 80
      vars:
        DATABASE_URL: "mysql://writefreely:${MYSQL_PASSWORD}@mysql.pod:3306/writefreely?parseTime=true"
        WRITEFREELY_DB_USER: writefreely
        WRITEFREELY_DB_NAME: writefreely
      volumes:
        - name: writefreely-app-data
          size: 5Gi
          mountPath: /var/www/writefreely
    - name: mysql
      image: mirror.gcr.io/library/mysql:8
      servicePorts:
        - 3306
      vars:
        MYSQL_DATABASE: writefreely
        MYSQL_USER: writefreely
        MYSQL_PASSWORD: ${MYSQL_PASSWORD}
        MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      volumes:
        - name: writefreely-mysql-data
          size: 10Gi
          mountPath: /var/lib/mysql
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-29T20:18:04Z | analyzed | initial repo analysis |
| 2026-06-29T20:23:50Z | success | deployed https://relaxed-weasel-writefreely.cloud.nexlayer.ai |
<!-- nexlayer:end -->
