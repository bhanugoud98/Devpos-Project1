# 📘 Master Interview Guide: Cloud-Native Task Manager

**Goal**: This document is your "cheat sheet" to explain every single decision, tool, and line of code in this project to an interviewer. It covers the **WHY**, **HOW**, and **WHAT** of the entire stack.

---

## 🏗️ 1. High-Level Architecture

### The "What"
This is a **3-Tier Microservices Application** deployed on Kubernetes.
1.  **Frontend**: Nginx serving static HTML/JS.
2.  **Backend**: Python Flask API.
3.  **Database**: In-memory list (simulating a DB for this MVP).

### The "Why"
*   **Why Microservices?** To decouple the frontend and backend. This allows them to be developed, scaled, and deployed independently. If the backend needs more CPU, I can scale it without touching the frontend.
*   **Why 3-Tier?** It's the industry standard pattern. Separation of concerns: Presentation Layer (UI), Logic Layer (API), and Data Layer.

### Architecture Diagram
```mermaid
graph TD
    User[User Browser] -->|HTTP/80| LB[K8s Service: Frontend]
    LB --> PodFE[Pod: Frontend (Nginx)]
    PodFE -->|AJAX Calls| SvcBE[K8s Service: Backend]
    SvcBE --> PodBE[Pod: Backend (Flask)]
    PodBE --> DB[(In-Memory DB)]
    
    subgraph Kubernetes Cluster
        LB
        PodFE
        SvcBE
        PodBE
    end
```

---

## 🐳 2. Containerization (Docker)

### The "What"
I used **Docker** to package the application and its dependencies into lightweight, portable containers.

### The "How"
*   **Frontend Dockerfile**: Uses `nginx:alpine` (lightweight Linux) to serve the static files.
*   **Backend Dockerfile**: Uses `python:3.9-slim`. I install dependencies from `requirements.txt` and run the Flask app.

### The "Why"
*   **Consistency**: "It works on my machine" is solved. The container runs the same on my laptop as it does in the Kubernetes cluster.
*   **Isolation**: The backend Python version doesn't conflict with any other Python versions on the host server.

### 💡 Interview Question: "Explain your Dockerfile optimization."
**Answer**: "I used `alpine` and `slim` base images to keep the image size small (under 100MB usually). This speeds up deployment times and reduces the attack surface for security."

---

## ☸️ 3. Orchestration (Kubernetes)

### The "What"
I used **Kubernetes (K8s)** to manage the containers. Docker runs the container; Kubernetes decides *where* to run it and keeps it running.

### The "How"
*   **Deployments**: I defined `Deployment` manifests to tell K8s "I want 2 replicas of the backend". If one crashes, K8s automatically restarts it (Self-healing).
*   **Services**: I used `Service` manifests to create stable internal IP addresses. The Frontend talks to the Backend Service, not individual Pod IPs (which change).

### The "Why"
*   **Scalability**: I can change `replicas: 2` to `replicas: 10` in seconds to handle high traffic.
*   **High Availability**: With multiple replicas, if one node fails, the app stays online.

### 💡 Interview Question: "What is the difference between ClusterIP and NodePort?"
**Answer**: "I used `ClusterIP` for the backend because it should only be accessible *inside* the cluster (security). I would use `NodePort` or `LoadBalancer` for the frontend to expose it to the *outside* world."

---

## 🏗️ 4. Infrastructure as Code (Terraform)

### The "What"
I used **Terraform** to provision the Kubernetes resources automatically.

### The "How"
*   **Provider**: I used the `kubernetes` provider to talk to my local cluster.
*   **Resources**: I defined `kubernetes_deployment` and `kubernetes_service` in `main.tf`.

### The "Why"
*   **Reproducibility**: I can destroy the entire cluster and recreate it exactly as it was with `terraform apply`. No manual clicking in dashboards.
*   **Version Control**: My infrastructure is code (`.tf` files), so I can track changes in Git just like application code.

---

## 🔄 5. CI/CD (GitHub Actions)

### The "What"
I built a **Continuous Integration/Continuous Deployment** pipeline to automate testing and delivery.

### The "How"
*   **CI (Continuous Integration)**: Triggers on Pull Requests. It runs unit tests (e.g., `pytest`). If tests fail, I can't merge.
*   **CD (Continuous Deployment)**: Triggers on merge to `main`. It builds the Docker images, tags them, and pushes them to a registry (Docker Hub).

### The "Why"
*   **Speed**: No manual deployments. I merge code, and minutes later it's live.
*   **Quality**: Bad code is caught by tests before it reaches production.

---

## 📊 6. Monitoring (Prometheus & Grafana)

### The "What"
I implemented **Observability** to see what's happening inside the app.

### The "How"
*   **Prometheus**: It "scrapes" (collects) metrics from the application every 15 seconds.
*   **Grafana**: It connects to Prometheus and visualizes the data (graphs, charts).

### The "Why"
*   **Proactive**: I can see if memory usage is spiking *before* the server crashes.
*   **Debugging**: If users report "slowness", I can look at the "Request Latency" graph to confirm and pinpoint the issue.

---

## 🌟 STAR Method Cheat Sheet (Behavioral Questions)

**Situation**: "I wanted to build a full-stack project to demonstrate modern DevOps practices."
**Task**: "My goal was to create a scalable, monitored application using industry-standard tools like K8s and Terraform."
**Action**: "I containerized the app with Docker, wrote Terraform scripts for IaC, set up a CI/CD pipeline in GitHub Actions, and added Prometheus monitoring."
**Result**: "I now have a fully automated, self-healing application that can be deployed in minutes, demonstrating my ability to handle the full DevOps lifecycle."
