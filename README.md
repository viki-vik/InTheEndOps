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

├── argocd
│   └── wordpress-app.yaml
├── helm-charts
│   └── wordpress-chart
│       ├── Chart.yaml
│       ├── templates
│       └── values.yaml
└── terraform
    ├── ingress.yaml
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    ├── values.yaml
    └── variables.tf

## Deployment Steps

Follow these steps to deploy the WordPress application:

### 1. Clone the Repository

    git clone <repository-url>
    cd <repository-directory>

### 2. Install Argo CD

#### a. Terraform Setup:

Navigate to the `argocd/terraform` directory:

    cd argocd/terraform

Initialize Terraform and apply the configuration. You may need to adjust the provider configuration to match your setup:

    terraform init
    terraform plan
    terraform apply

#### b. Install Argo CD using Helm:

Navigate to the `argocd/helm` directory:

    cd ../helm

Install Argo CD using the Helm chart. You might need to adjust the `values.yaml` file to customize your Argo CD installation.

    helm install argocd . -n argocd --create-namespace

### 3. Configure Argo CD

* **Access Argo CD:** Determine how to access the Argo CD UI. This usually involves port forwarding or using an ingress controller. For Rancher Desktop, Traefik is often used.
* **Get the Argo CD Admin Password:**

        kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

* **Log in to Argo CD:** Use the username `admin` and the password obtained in the previous step to log in to the Argo CD UI.

### 4. Deploy WordPress and MariaDB

* **Create the Argo CD Application:** Ensure the `argocd-app.yaml` file is correctly configured with your repository URL and path to the `wordpress-mariadb` chart. Then, apply it to your cluster:

        kubectl apply -n argocd -f argocd-app.yaml

* **Argo CD Sync:** Argo CD will now synchronize the application, deploying WordPress and MariaDB to your Rancher Desktop cluster.

### 5. Access WordPress

* Once the Argo CD application is synced and the WordPress pods are running, you can access WordPress through your browser. Since we are using a `LoadBalancer` service in the WordPress Helm chart, with Rancher Desktop, you can usually access it via `http://localhost`.

