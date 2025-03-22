### AWS FinOps

1.  **How to reduce EKS cluster costs:**

    * Right-size nodes.
    * Use Spot Instances.
    * Autoscaling (nodes & pods).
    * Optimize storage classes.
    * Remove unused resources.

2.  **How to reduce costs of specific AWS resources:**

    **General Cost Optimization Strategies (Apply to all resources where relevant):**

    * Implement tagging and use cost tools (AWS Cost Explorer, Budgets).
    * Auto Scaling.
    * Right-sizing (db/ebs storages, nodes & pods).
    * Systematically remove unused resources.


    **Resource-Specific Recommendations:**

    * **`euc1-StorageIOUsage` (EBS, RDS Storage I/O):**
        * Optimize database queries/indexing (RDS).
        * Right-size EBS volumes.
        * Use `gp3` over `gp2` for price/performance.
    * **`EU-InstanceUsage:db.r6g.xl` & `EU-Multi-AZUsage:db.m6g.large` (RDS):**
        * Right-size instances.
        * Use Reserved Instances/Savings Plans for steady workloads.
        * Evaluate Multi-AZ necessity.
        * Schedule off-hour shutdowns.
    * **`EU-BoxUsage:c5.large` (EC2):**
        * Right-sizing.
        * Explore newer instance types (`c6i`, `c7g`, Graviton).
        * Spot Instances (non-critical).
        * Reserved Instances/Savings Plans (long-term).
        * Auto Scaling.
        * Scheduled Instances (predictable on/off).
        * Optimize applications (efficiency, caching).
        * Terminate unused instances.
    * **`EU-Natgateway-Hours` (NAT Gateway):**
        * Use VPC endpoints.
        * Minimize data transfer.
        * Carefully consider NAT instances.
    * **`EU-PaidKubernetesAuditLogsAnalyzed` (EKS Audit Logs):**
        * Filter audit logs.
        * Adjust log retention.
        * Consider alternative logging.
    * **`EU-AmazonEKS-HoursPerCluster` (EKS Control Plane):**
        * Consolidate clusters.
        * Delete unused clusters.
        * Evaluate Fargate.

### Terraform

Running `terraform plan -target 'data.aws_eks_cluster.cluster'` retrieves and displays EKS cluster information without infrastructure changes.    This includes:
    ** Cluster name
    ** ARN (Amazon Resource Name)
    ** Endpoint (the Kubernetes API server endpoint)
    ** Certificate authority data (for connecting to the API server)
    ** Version
    ** Status
    ** VPC configuration
    ** And other AWS-specific settings related to the cluster itself.
Errors occur if the cluster or module output is undefined.

### Kubernetes

**External Secrets Operator (ESO)**

ESO bridges Kubernetes and external secret management systems, automating secret fetching and synchronization.

**Benefits:**

* **Security:** Secrets are stored externally.
* **Centralized Management:** Easier access and rotation control.
* **Automation:** Reduces human error in secret management.
* **GitOps-Friendly:** Manage `ExternalSecret` definitions in Git.

**ESO Process:**

1.  **ExternalSecret Definition:** Defines the external secret location.
2.  **ESO Controller:** Monitors `ExternalSecret` resources.
3.  **Fetching Secrets:** Retrieves secrets from external stores.
4.  **Creating Kubernetes Secrets:** Creates/updates Kubernetes Secrets with fetched data.
5.  **Application Access:** Applications access secrets via Kubernetes Secrets.
6.  **Keeping Secrets Up-to-Date:** ESO controller updates Kubernetes Secrets on changes.