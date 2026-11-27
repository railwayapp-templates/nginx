# Task 6 — Log Aggregation with Grafana Loki
 1. Overview

This task implements centralized application log aggregation using Grafana Loki, Promtail, and Grafana.

Promtail collects Docker container logs and forwards them to Loki. Grafana is used to query, visualize, and investigate application logs.

 2. Components
Loki: Log aggregation and storage.
Promtail: Log collection and forwarding.
Grafana: Log visualization and exploration.
NGINX: Application used to generate test access logs.

 3. Configuration Files

The following configuration files were created:

monitoring/docker-compose.yaml
monitoring/loki-config.yaml
monitoring/promtail-config.yaml

All configuration files are committed to the repository.

 4. Starting the Stack

The monitoring stack was started using:

bash
cd monitoring
docker compose up -d

Container status was checked using:

bash
docker compose ps


Loki readiness was verified using:

bash
curl http://localhost:3100/ready


Grafana was accessed at:

http://localhost:3000

Loki was configured as a Grafana data source using:

http://loki:3100

 5. Promtail Labels

Promtail was configured to discover Docker containers and attach the following labels:

Label	Description
job	Docker log source
container	Container name
container_id	Docker container ID
service	Docker Compose service name

These labels make it possible to filter logs by application and container.

 6. Log Generation and Testing

A missing NGINX endpoint was deliberately requested to generate a non-200 HTTP response.

# Test command:

bash
curl -i http://localhost:[NGINX_DOCKER_PORT]/this-page-does-not-exist


Expected HTTP status:

404 Not Found

The resulting access log was checked against the NGINX container logs.

 7. LogQL Queries
Query 1: All Docker logs
logql
{job="docker"}


Result: [Record actual result]

Query 2: NGINX access logs
logql
{job="docker", container=~".*nginx.*"}


Result: [Record actual result]

Query 3: NGINX 404 responses
logql
{job="docker", container=~".*nginx.*"} |= "404"


Result: [Record actual result]

Query 4: Non-200 HTTP responses
logql
{job="docker", container=~".*nginx.*"}
| regexp `\" (?P<status>[1-5][0-9][0-9]) `
| status != "200"


Result: [Record the actual matching HTTP status codes and log entries]

### 8. Problems Encountered and Resolutions

Document the actual issues encountered during setup.

Examples to investigate if applicable:

Loki connection failures: checked container health and Loki readiness.
Promtail not collecting logs: checked Docker socket access and container discovery.
No NGINX logs appearing: generated a test request and checked Docker container logs.
Grafana data source connection issues: verified the internal Docker service URL.

### 9. Screenshot Evidence

Grafana Explore screenshot:

docs/screenshots/grafana-loki-explore.png

The screenshot demonstrates successful log ingestion and the LogQL query used to identify non-200 NGINX responses.

 10. Conclusion

The logging stack was deployed using Docker Compose. Promtail was configured to collect Docker logs and attach meaningful labels. Loki received the application logs, and Grafana Explore was used to query NGINX access logs and identify non-200 HTTP responses.