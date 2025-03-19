
CI/CD Blueprint for deploying Python application to EKS using GitHub Actions, ECR, Argo CD, and GitOps principles.
CI/CD pipeline from Code PR → Deployment in Prod (PR->CI->Dev->Prod)
1. Feature Development:
	- Developers work on a feature in a feature branch.
	- They write code, unit tests, integration tests, and create a Dockerfile.
	- The feature branch is pushed to GitHub.
2. Pull Request:
	- A pull request (PR) is created to merge the feature branch into the Dev branch.
	- GitHub Actions runs linting and security checks.
	- If checks fail, developers fixes the issues.
	- If checks pass, code review and approval are required.
	- Once approved, the PR is merged into Dev.
3. CI Pipeline:
	- A GitHub Actions CI pipeline is triggered on the Dev branch.
	- Unit tests are run. If they fail, the pipeline stops and notifies the team via Slack.
	- Integration tests are run. If they fail, the pipeline stops and notifies the team via Slack.
	- A Docker image is built and tagged with Dev-TAG or commit SHA.
	- The image is pushed to ECR.
4. CD to Development:
	- ArgoCD syncs the Dev application from the GitOps repository.
	- ArgoCD deploys the application to the EKS Dev environment.
	- If the deployment fails, ArgoCD rolls back to the previous version and notifies the team via Slack.
5. Promotion to Production:
	- The Dev branch is promoted to the main branch via PR.
	- A GitHub Actions CI pipeline is triggered on the main branch.
	- Unit and integration tests are run. If they fail, the pipeline stops and notifies the team via Slack.
	- A Docker image is built and tagged with latest and TAG (e.g., semantic version).
	- The image is pushed to ECR.
	- ArgoCD syncs the prod application from the GitOps repository.
	- ArgoCD deploys the application to the EKS prod environment.
	- If the deployment fails, ArgoCD rolls back and notifies the team.
	- If the deployment succeeds, the team is notified via Slack.
