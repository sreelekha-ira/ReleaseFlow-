# PowerShell helper to run ReleaseFlow locally on Windows 11 with Minikube + Docker Desktop
Write-Host "1) Start Minikube"
minikube start --driver=docker
Write-Host "2) Point shell to Minikube docker env"
minikube docker-env | Invoke-Expression
Write-Host "3) Build image"
docker build -t releaseflow-app:local .
Write-Host "4) Apply k8s resources"
kubectl apply -f deployment/
Write-Host "5) Port-forward service"
kubectl -n releaseflow port-forward svc/releaseflow-service 5000:5000
Write-Host "Open http://localhost:5000 in browser"
