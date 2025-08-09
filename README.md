# Coder Kubernetes Template

A [Coder](https://coder.com/) template for creating cloud development environments running on Kubernetes. This template provisions development workspaces as Kubernetes pods with persistent storage, code-server access, and configurable resources.

## 🚀 Quick Start

1. **Prerequisites:**
   - A Kubernetes cluster with appropriate permissions
   - [Coder](https://coder.com/docs/v2/latest/install) installed and configured
   - kubectl access to your Kubernetes cluster

2. **Deploy the template:**
   ```bash
   coder templates push kubernetes -d template-kubernetes
   ```

3. **Create a workspace:**
   ```bash
   coder create my-dev-workspace -t kubernetes
   ```

## 📁 Project Structure

```
├── .github/
│   └── workflows/
│       └── coder-template-update.yaml    # CI/CD pipeline for testing and publishing
├── template-kubernetes/
│   ├── README.md                         # Template-specific documentation
│   └── main.tf                          # Terraform configuration for the template
├── renovate.json                         # Dependency update configuration
├── validate.sh                          # Local validation script
├── CONTRIBUTING.md                       # Contribution guidelines and setup
└── README.md                            # This file
```

### Key Files Explained

- **`template-kubernetes/main.tf`**: The core Terraform configuration defining the Coder template, including Kubernetes resources, parameters, and workspace configuration
- **`.github/workflows/coder-template-update.yaml`**: Automated testing and publishing pipeline
- **`validate.sh`**: Local validation script for checking Terraform formatting and configuration
- **`renovate.json`**: Configuration for Renovate bot to automatically update dependencies (Terraform providers, Docker images)
- **`CONTRIBUTING.md`**: Comprehensive guide for contributors including setup, testing, and development workflows

## 🔄 Dependency Management

This repository uses [Renovate](https://renovatebot.com/) for automated dependency updates.

### Renovate Configuration

The `renovate.json` file configures:
- **Auto-merge**: Automatically merges updates when all checks pass
- **Squash strategy**: Uses squash commits for cleaner history
- **Auto-merge comment**: Adds clear indication of automated merges

### Managed Dependencies

Renovate automatically monitors and updates:

1. **Terraform Providers**: 
   - Coder provider (`coder/coder`)
   - Kubernetes provider (`hashicorp/kubernetes`)

2. **Docker Images**:
   - Development image: `ghcr.io/frantche/coder-full`
   - Updates tracked via special comment in `main.tf`

3. **GitHub Actions**:
   - Action versions in workflow files
   - Ensures security and feature updates

### Update Process

1. Renovate creates PRs for available updates
2. GitHub Actions automatically test the changes
3. If tests pass, changes are auto-merged
4. New template version is published to Coder

This ensures dependencies stay current while maintaining stability through automated testing.

## 🛠️ Template Features

- **Kubernetes Pod Workspaces**: Each workspace runs as a Kubernetes pod
- **Persistent Storage**: Home directory persisted via PersistentVolumeClaim
- **Code-Server**: Web-based VS Code editor accessible through Coder dashboard
- **Configurable Resources**: Adjustable CPU, memory, and disk size
- **Docker Support**: Docker-in-Docker for containerized development
- **Authentication Options**: Support for both in-cluster and kubeconfig authentication

## 🔧 Configuration Options

The template supports several parameters that can be configured when creating workspaces:

- **CPU**: 2, 4, 6, or 8 cores
- **Memory**: 2, 4, 6, or 8 GB RAM  
- **Home Disk Size**: Configurable persistent storage (1-99999 GB)
- **Namespace**: Target Kubernetes namespace for workspace deployment

## 🏃‍♂️ GitHub Actions Workflow

This repository includes a sophisticated CI/CD pipeline that automatically tests and publishes the Coder template.

### Workflow Overview

The workflow is defined in `.github/workflows/coder-template-update.yaml` and consists of two main jobs:

#### 🧪 Pull Request Testing (`test` job)

**Trigger**: Pull requests to `main` branch

**Steps**:
1. **Environment Setup**
   - Checkout repository code
   - Install Terraform (latest version)
   - Setup Coder CLI with authentication

2. **Terraform Validation**
   ```bash
   terraform init
   terraform fmt -check -diff
   terraform validate
   ```

3. **Live Template Testing**
   - Pushes template with unique suffix: `kubernetes-ci-{commit-sha}`
   - Uses commit SHA as version name
   - Deployed with `activate=false` to avoid affecting production

4. **Workspace Deployment Test**
   - Creates test workspace: `workspace-ci-{commit-sha}`
   - Configures with standard parameters (2 CPU, 2GB RAM, 10GB disk)
   - Verifies successful deployment with `coder show`

5. **Automatic Cleanup**
   - Deletes test workspace and template
   - Runs even if previous steps fail (`if: always()`)

#### 🚀 Production Publishing (`publish` job)

**Trigger**: Pushes to `main` branch (after PR merge)

**Steps**:
1. **Environment Setup** (same as test job)
2. **Template Publishing**
   - Pushes template with production name: `kubernetes`
   - Uses commit SHA as version identifier  
   - Sets `activate=true` to make it the default version
   - Includes commit message as version description

### Configuration

#### Required Secrets
- `CODER_SESSION_TOKEN`: Authentication token for your Coder instance
  - Generate via: `coder tokens create --lifetime 87600h`
  - Add to repository secrets in GitHub

#### Environment Variables
- `TEMPLATE_NAME`: Set to "kubernetes" (the production template name)
- Coder instance URL: Currently set to `https://coder.frantchenco.page`

#### Default Parameters
The workflow deploys test workspaces with these parameters:
- `namespace`: `coder-workspace`
- `cpu`: `2`
- `memory`: `2`  
- `home_disk_size`: `10`

### Workflow Benefits

- ✅ **Automated Testing**: Every PR is tested with real Coder deployment
- ✅ **Safe Deployment**: Test resources are isolated and automatically cleaned up
- ✅ **Version Control**: Each deployment tagged with commit SHA
- ✅ **Zero Downtime**: New versions published without affecting existing workspaces
- ✅ **Rollback Ready**: Previous versions remain available in Coder

### Monitoring Workflow

You can monitor the workflow by:
1. **GitHub Actions Tab**: View live logs and status
2. **Coder Dashboard**: Check for test templates/workspaces during PR testing
3. **Template Versions**: Verify new versions appear after merge

### Customizing the Workflow

To adapt this workflow for your environment:

1. **Update Coder URL**: Change `access_url` in the workflow file
2. **Modify Parameters**: Adjust default workspace parameters as needed
3. **Change Namespace**: Update the `namespace` variable
4. **Add Validation**: Include additional validation steps if required

## 🧪 Testing

### Local Validation
```bash
# Run local Terraform validation
./validate.sh
```

### Manual Testing
1. Fork this repository
2. Set up the required secrets in your GitHub repository
3. Create a pull request to trigger the test workflow
4. Review the workflow logs to ensure successful deployment

## 📚 Documentation

- [Template README](template-kubernetes/README.md) - Detailed template documentation
- [Coder Documentation](https://coder.com/docs/) - Official Coder documentation
- [Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs) - Terraform Kubernetes provider docs

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute to this project.

## 📄 License

This project is open source. Please check the repository for license details.

## 🆘 Support

- Create an [issue](https://github.com/Frantche/coder-template-kubernetes/issues) for bug reports or feature requests
- Check [Coder Community](https://github.com/coder/coder/discussions) for general Coder questions
- Review the [troubleshooting guide](template-kubernetes/README.md) in the template documentation