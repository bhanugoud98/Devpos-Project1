# Cloud-Native Task Manager

A complete DevOps portfolio project demonstrating a 3-tier application deployed with modern cloud-native practices.

## 🚀 Project Overview
This project is a simple Task Manager application built to showcase end-to-end DevOps skills, including:
- **Containerization**: Docker & Docker Compose
- **Orchestration**: Kubernetes (K8s)
- **Infrastructure as Code**: Terraform
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus & Grafana

## 🛠 Tech Stack
- **Frontend**: HTML, CSS, JavaScript (Nginx)
- **Backend**: Python Flask
- **Infrastructure**: Docker, Kubernetes, Terraform
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus, Grafana

## 📂 Directory Structure
```
.
├── backend/            # Flask API
├── frontend/           # HTML/JS Client
├── k8s/                # Kubernetes Manifests
├── terraform/          # Terraform Configuration
├── .github/workflows/  # CI/CD Pipelines
├── monitoring/         # Prometheus & Grafana Configs
└── docker-compose.yml  # Local Development
```

## 🏃‍♂️ How to Run

### Local Development (Docker Compose)
```bash
docker-compose up --build
```
Access the frontend at `http://localhost:8080`.

### Kubernetes Deployment
```bash
kubectl apply -f k8s/
```

### Infrastructure Provisioning
```bash
cd terraform
terraform init
terraform apply
```
