# Case Study — ReleaseFlow

Project goal: Build an end-to-end automated release pipeline demonstrating CI/CD, containerization, Kubernetes deployment, monitoring, versioning, and rollback.

My role: Solo engineer — designed, implemented, and validated the pipeline, infrastructure-as-code, and deployment automation.

What I built:
- Jenkins CI pipeline that runs unit tests, builds Docker images, tags releases, pushes images, and deploys to Kubernetes.
- Automated image tagging strategy using BUILD_NUMBER + git short hash for traceability.
- Rolling deployments with readiness/liveness probes and rollback strategy.
- Simple health checks and post-deploy smoke tests.
- Monitoring basics (Prometheus scrape config) and Grafana dashboard placeholder.

Resume bullet:
Built "ReleaseFlow" — an automated CI/CD pipeline using Jenkins, Docker, and Kubernetes. Implemented image tagging, automated deployments, rollback, and monitoring integration (Prometheus/Grafana).
