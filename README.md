# WordPress Deployment on Rancher Desktop with Argo CD

This repository automates the deployment of a WordPress application with MariaDB on a local Kubernetes cluster created with Rancher Desktop. It uses Argo CD for GitOps-style continuous deployment, with Argo CD deployed using Helm and Terraform.

## Prerequisites

* **Rancher Desktop:** Ensure you have Rancher Desktop installed and running with Kubernetes enabled.
* **kubectl:** The Kubernetes command-line tool must be installed and configured to connect to your Rancher Desktop cluster.
* **helm:** The Helm package manager must be installed.
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
    └── terraform     # Terraform and Helm files for Argo CD deployment

## Deployment Steps

Follow these steps to deploy the WordPress application:

### 1. Clone the Repository

    git clone <repository-url>
    cd <repository-directory>

### 2. Install Argo CD

#### a. Terraform Setup:

Navigate to the `terraform` directory:

    cd terraform

Initialize Terraform and apply the configuration. You may need to adjust the provider configuration to match your setup:

    terraform init
    terraform plan
    terraform apply

### 2. Configure Argo CD

* **Access ArgoCD:** Determine how to access the Argo CD UI. This usually involves port forwarding:

        kubectl port-forward svc/argocd-server -n argocd 8080:443

* **Get the Argo CD Admin Password:**

        kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode

* **Log in to Argo CD:** Use the username `admin` and the password obtained in the previous step to log in to the Argo CD UI from `http://localhost:8080`

### 4. Deploy WordPress and MariaDB

* **Create the Argo CD Application:** Apply to your cluster:

        cd ../argocd
        kubectl apply -f wordpress-app.yaml -n argocd

* **Argo CD Sync:** Argo CD will now synchronize the application, deploying WordPress and MariaDB to your Rancher Desktop cluster.

        kubectl get applications -n argocd

### 5. Access WordPress

* Once the Argo CD application is synced and the WordPress pods are running, expose Wordpress service:

        kubectl port-forward svc/argocd-server -n argocd 8080:443

you can access WordPress through your browser via `http://localhost`.
