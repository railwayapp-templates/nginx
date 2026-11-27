DevOps Intern Final Task

!CI/CD Pipeline

A containerised Nginx application deployed using Docker, GitHub Actions, GitHub Container Registry (GHCR), and HashiCorp Nomad.

DevOps Internship Final Project

![CI Status](https://github.com/OWNER/REPOSITORY/actions/workflows/WORKFLOW.yml/badge.svg)

Author: Samson Olawoyin
Submission Date: 25 November 2026
Project: DevOps Internship Final Project

Table of Contents
Project Overview
Architecture
Prerequisites
Quick Start
Project Tasks
Troubleshooting
Known Limitations
Screenshots
Project Overview

This project demonstrates the implementation of a DevOps workflow covering application containerization, continuous integration, container image management, infrastructure deployment, service discovery, monitoring, and centralized log aggregation.

The project uses Docker, CI/CD automation, a container registry, HashiCorp Nomad, Consul, Grafana, Loki, and Promtail.

The primary objectives are:

Containerize the application.
Automate testing and validation through CI.
Build and publish application images.
Deploy the application using Nomad.
Integrate service discovery using Consul.
Monitor and aggregate application logs using Grafana Loki.
Provide reproducible documentation and deployment instructions.
Architecture

The architecture follows this workflow:

Source: Application source code and configuration are maintained in Git.
CI: Automated pipelines validate the code, run checks, and build the application image.
Registry: The built container image is published to a container registry.
Nomad: Nomad schedules and runs the application container.
Loki: Promtail collects application logs and forwards them to Loki for storage and querying.
Architecture Diagram
text
             DEVELOPER
                 |
                 v
          +--------------+
          | Git Repository|
          |   (Source)    |
          +--------------+
                 |
                 v
          +--------------+
          | CI Pipeline  |
          | Build & Test |
          +--------------+
                 |
                 v
          +--------------+
          |   Container  |
          |   Registry   |
          +--------------+
                 |
                 v
          +--------------+
          |    Nomad     |
          | Deployment   |
          +--------------+
                 |
                 v
          +--------------+
          | Application  |
          |   / NGINX    |
          +--------------+
                 |
                 v
          +--------------+
          |   Promtail   |
          | Log Collector|
          +--------------+
                 |
                 v
          +--------------+
          |     Loki     |
          | Log Storage  |
          +--------------+
                 |
                 v
          +--------------+
          |   Grafana    |
          | Log Explorer |
          +--------------+

       Consul: Service Discovery

Prerequisites

The following tools are required to run and validate this project.

Tool	Version
Docker Engine	[Insert installed version]
Docker Compose	[Insert installed version]
HashiCorp Nomad	[Insert installed version]
HashiCorp Consul	[Insert installed version]
ShellCheck	[Insert installed version]
Git	[Insert installed version]

Monitoring container images:

Component	Version
Grafana Loki	3.5.0
Grafana Promtail	3.5.0
Grafana	12.0.0

Install the prerequisites before following the Quick Start instructions.

Quick Start

Follow these steps to clone and start the application.

1. Clone the repository
bash
git clone git@github.com:samson-olawoyin/devops-intern-final

2. Enter the project directory
bash
cd devops-intern-final

3. Build and start the application
bash
docker pull ghcr.io/samson-olawoyin/devops-final-task-nginx:latest

Start Nomad Agent
sudo nomad agent -dev

Start Consul Agent
consul agent -dev -client=0.0.0.0

Start project using nomad
nomad job run ./nomad/nginx-app.nomad.hcl

Check nomad job status
nomad job status devops-final-task-nginx

Get Dynamic assigned nginx port, copy Allocation ID from nomad job status result, see docs/nomad job status.png
nomad alloc status ALLOCATION_ID

From the above command result, see docs/nomad alloc status.png to extract nginx port

4. Check running containers
bash
docker ps

5. Start the monitoring stack
bash
cd monitoring
docker compose up -d

6. Verify Loki
bash
curl http://localhost:3100/ready


Expected output:

text
ready

7. Access Grafana

Open:

http://localhost:3000

Use the configured Grafana credentials.

The application and monitoring services should now be running.

Project Tasks

This section documents the implementation, commands, verification results, and evidence for each assignment task.

Task 1 — Application Setup

Objective: [Describe the application setup requirement.]

Implementation:

[Explain how the application was configured.]

Commands executed:

bash
[Insert actual commands]


Observed output:

text
[Insert actual output]


Screenshot:

!Application running

Task 2 — Containerization with Docker

Objective: Containerize the application using Docker.

Implementation:

The application was containerized using a Dockerfile.

Commands executed:

bash
docker build -t devops-intern-app .
docker images
docker ps


Observed output:

text
[Insert actual image build and container status output]


Screenshot:

!Docker containers

Task 3 — Continuous Integration

Objective: Automate application validation and build processes.

Implementation:

[Describe your GitHub Actions or other CI workflow, including tests, linting and image building.]

Commands executed:

bash
[Insert actual validation commands]


Observed output:

text
[Insert actual successful test or pipeline output]


CI evidence:

!CI pipeline

Task 4 — Container Registry

Objective: Build and publish the application image to a container registry.

Implementation:

[Describe the registry used and how the application image was tagged and published.]

Commands executed:

bash
[Insert actual image tagging and publishing commands]


Observed output:

text
[Insert actual image push output]


Screenshot:

!Container registry

Task 5 — Deployment with Nomad and Consul

Objective: Deploy the application using HashiCorp Nomad and integrate service discovery using Consul.

Implementation:

[Describe your Nomad job configuration, deployment process, and Consul integration.]

Commands executed:

bash
nomad job run /nomad/nginx-app.nomad.hcl
nomad job status devops-final-task-nginx
consul members


Observed output:

ID            = devops-final-task-nginx
Name          = devops-final-task-nginx
Submit Date   = 2026-11-27T10:28:12+01:00
Type          = service
Priority      = 50
Datacenters   = dc1
Namespace     = default
Status        = running
Periodic      = false
Parameterized = false

Summary
Task Group  Queued  Starting  Running  Failed  Complete  Lost  Unknown
nginx       0       0         1        0       1         0     0

Latest Deployment
ID          = 195e35b5
Status      = successful
Description = Deployment completed successfully

Deployed
Task Group  Auto Revert  Desired  Placed  Healthy  Unhealthy  Progress Deadline
nginx       true         1        1       1        0          2026-11-27T10:38:33+01:00       

Allocations
ID        Node ID   Task Group  Version  Desired  Status   Created    Modified
02ae4936  faa33b6d  nginx       2        run      running  2h21m ago  2h21m ago


Task 6 — Log Aggregation with Grafana Loki

Objective: Centralize application logs using Grafana Loki and Promtail.

Implementation:

Three monitoring services were configured using Docker Compose:

Loki 3.5.0 — log storage and querying.
Promtail 3.5.0 — Docker log collection and forwarding.
Grafana 12.0.0 — log visualization and exploration.

Configuration files:

text
monitoring/
├── docker-compose.yaml
├── loki-config.yaml
├── promtail-config.yaml
└── loki_setup.md


Promtail was configured to collect Docker container logs and attach the following labels:

Label	Description
job	Log source
container	Container name
service	Docker Compose service

Commands executed:

bash
cd monitoring
docker compose up -d
docker compose ps
docker logs promtail --tail 50
curl http://localhost:3100/ready


LogQL queries:

Display Docker logs:

logql
{job="docker"}


Filter NGINX logs:

logql
{job="docker", container=~".*nginx.*"}


Find NGINX 404 responses:

logql
{job="docker", container=~".*nginx.*"} |= "404"


Find non-200 responses:

logql
{job="docker", container=~".*nginx.*"}
| regexp `\" (?P<status>[1-5][0-9][0-9]) `
| status != "200"


!Grafana Loki Explore

Detailed setup and test results are available in monitoring/loki_setup.md.

Troubleshooting

The following issues were encountered during implementation and investigated.

1. Promtail configuration path was a directory

Problem:

Promtail repeatedly failed with:

text
Unable to parse config:
read /etc/promtail/config.yaml: is a directory.


Cause:

The host path monitoring/promtail-config.yaml was accidentally created as a directory rather than a YAML file.

Resolution:

The incorrect directory was removed, and the Promtail configuration was recreated as a regular YAML file.

Verification:

bash
file monitoring/promtail-config.yaml

monitoring/promtail-config.yaml: ASCII text

2. Docker bind mount failed

Problem:

Docker reported:

text
not a directory:
Are you trying to mount a directory onto a file
(or vice-versa)?


Cause:

The source configuration path was a directory while the destination /etc/promtail/config.yaml was a file.

Resolution:

The configuration file was corrected, and the bind mount was checked to ensure that both paths had the expected types.

Promtail was recreated using:

bash
docker compose up -d --force-recreate promtail

3. Promtail HTTP endpoint was unreachable

Problem:

The following command failed:

bash
curl http://localhost:9080/ready

curl: (7) Failed to connect to localhost port 9080


Cause:

Port 9080 was not published from the Promtail container to the host.

Resolution:

The Promtail service was configured with:

yaml
ports:
  - "9080:9080"


The Promtail HTTP server was configured to listen on port 9080.

The container was then recreated and the endpoint tested again.

Final verification of Promtail readiness and log delivery must be recorded here.
Known Limitations

Although the project demonstrates the required DevOps workflow, some aspects are not yet production-ready.

Monitoring security: The development Grafana credentials are configured for local testing and should be replaced with secure credentials and secret management.
Log storage: Loki uses local filesystem storage, which is not suitable for highly available production deployments.
Promtail: Promtail is deprecated upstream. Grafana Alloy would be a better choice for a new production deployment.
Container access: Promtail accesses the Docker socket to discover containers. This introduces security considerations.
High availability: The monitoring stack currently uses a single Loki instance without a distributed deployment.
Log retention: The current Loki configuration uses a seven-day retention period.
Deployment security: Production deployment would require additional network restrictions, TLS, authentication, and secrets management.

With more time, I would:

Migrate Promtail to Grafana Alloy.
Configure secure credentials and secret management.
Introduce durable object storage for Loki.
Implement monitoring alerts and dashboards.
Improve deployment resilience and high availability.
Add more automated integration and deployment tests.
Screenshots

Screenshots are stored in docs/screenshots/ and referenced inline throughout the relevant task sections.

The evidence includes application execution, CI pipeline results, registry publishing, Nomad deployment, and Grafana log exploration.

Conclusion

This project demonstrates an end-to-end DevOps workflow, from source code management and automated CI to container image publishing, infrastructure deployment, and centralized log aggregation.

The implementation provides a foundation for reproducible deployments, automated validation, and application observability.

All configuration files and implementation documentation are maintained in this repository.