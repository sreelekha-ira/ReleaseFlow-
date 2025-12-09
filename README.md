# ReleaseFlow — Automated CI/CD Release Pipeline on Kubernetes

This repo contains a full end-to-end demo project for a Release Management / DevOps portfolio:
- Jenkins pipeline (Jenkinsfile)
- Dockerized Flask app
- Kubernetes manifests (deployment, service, ingress, namespace)
- Build, deploy, rollback scripts
- Monitoring placeholders (Prometheus, Grafana)
- Documentation and case study
- Windows helper script and demo recording instructions

## Quick start (minikube)
1. Start minikube: `minikube start --driver=docker`
2. Point Docker to minikube: `minikube docker-env | Invoke-Expression` (PowerShell) or `eval $(minikube docker-env)` (bash)
3. Build image: `docker build -t releaseflow-app:local .`
4. Apply k8s: `kubectl apply -f deployment/`
5. Port-forward: `kubectl -n releaseflow port-forward svc/releaseflow-service 5000:5000`
6. Open: http://localhost:5000

See docs/CASE_STUDY.md for interview-ready bullets and docs/ARCHITECTURE.md for diagrams.
