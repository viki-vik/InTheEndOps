# WordPress Deployment on Rancher Desktop with ArgoCD

This repository automates the deployment of a WordPress application with MariaDB on a local Kubernetes cluster created with Rancher Desktop, Minikube or equivalent. It uses ArgoCD for GitOps-style continuous deployment, with ArgoCD deployed using Helm and Terraform.

## Prerequisites

* **Rancher Desktop:** Ensure you have Rancher Desktop installed and running with Kubernetes enabled.
* **kubectl:** The Kubernetes command-line tool must be installed and configured to connect to your Rancher Desktop cluster.
* **Terraform:** Terraform must be installed.
* **Git:** Git must be installed.

## Repository Structure

The repository is structured as follows:

    ├── argocd/               
    │   ├── wordpress-app.yaml  # Wordpress app manifests
    ├── docs
    │   ├── stage1    # CICD
    │   ├── stage2    # ArgoCD and app screenshots
    │   └── stage3    # Answers for questionary       
    └── terraform     # Terraform and Helm files for ArgoCD deployment

## Deployment Steps

Follow these steps to deploy the WordPress application:

### 1. Clone the Repository

    git clone <repository-url>
    cd <repository-directory>

### 2. Install ArgoCD

#### a. Terraform Setup:

Navigate to the `terraform` directory:

    cd terraform

Initialize Terraform and apply the configuration. You may need to adjust the provider configuration to match your setup:

    terraform init
    terraform plan
    terraform apply

### 2. Configure ArgoCD

* **Access ArgoCD:** Forward traffic from port 8080 on your local machine to port 443 on the argocd-server service inside the Kubernetes cluster:

        kubectl port-forward svc/argocd-server -n argocd 8080:443

* **Get the ArgoCD Admin Password:**

        kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode

* **Log in to ArgoCD:** Use the username `admin` and the password obtained in the previous step to log in to the ArgoCD UI from `https://localhost:8080`

### 4. Deploy WordPress and MariaDB

* **Create the ArgoCD Application:** Apply to your cluster:

        cd ../argocd
        kubectl apply -f wordpress-app.yaml -n argocd

* **ArgoCD Sync:** ArgoCD will now synchronize the application, deploying WordPress and MariaDB to your Rancher Desktop cluster.

        kubectl get applications -n argocd -o wide

### 5. Access WordPress

* Once the ArgoCD application is synced and the WordPress pods are running, expose Wordpress service and verify:

        kubectl port-forward svc/wordpress 8080:80 -n wordpress
        kubectl get svc -n wordpress -o wide

Access WordPress through your browser via `http://localhost:8080`.
