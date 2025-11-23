# Install & Quickstart

## Prereqs (local)
- Java 17
- Maven
- Docker (or Docker Desktop)
- kubectl (to talk to your k8s cluster)
- Helm (optional)
- Jenkins

## Build locally
1. mvn -f application/pom.xml clean package

## Build Docker image
2. docker build -t REGISTRY_URL/banking-app:1.0 -f docker/Dockerfile .

## Push to registry
3. docker push REGISTRY_URL/banking-app:1.0

## Deploy to Kubernetes
4. kubectl apply -f kubernetes/configmap.yaml
5. kubectl apply -f kubernetes/deployment.yaml
6. kubectl apply -f kubernetes/service.yaml
7. kubectl apply -f kubernetes/ingress.yaml

## Monitor
- Grafana: http://<grafana-host>:3000 (default admin/admin)
- Prometheus: http://<prometheus-host>:9090
- Kibana: http://<kibana-host>:5601
