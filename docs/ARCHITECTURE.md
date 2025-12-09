# ReleaseFlow Architecture

Developer -> GitHub -> Jenkins -> Docker Registry -> Kubernetes (releaseflow namespace) -> Users
                                          -> Prometheus -> Grafana
                                          -> Slack notifications

See Jenkinsfile for pipeline steps and docs/CASE_STUDY.md for hiring-focused write-up.
