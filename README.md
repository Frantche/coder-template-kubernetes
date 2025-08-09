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
└── README.md                            # This file
```

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

This repository includes automated CI/CD with the following stages:

### Pull Request Testing (`test` job)
- **Terraform Validation**: Checks formatting and validates configuration
- **Template Testing**: Pushes a temporary template to Coder instance
- **Workspace Deployment**: Creates and verifies a test workspace
- **Cleanup**: Removes test resources after completion

### Main Branch Publishing (`publish` job)  
- **Template Publishing**: Pushes the template to production Coder instance
- **Version Management**: Uses commit SHA for versioning
- **Activation**: Automatically activates the new template version

The workflow requires these secrets:
- `CODER_SESSION_TOKEN`: Authentication token for Coder instance

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