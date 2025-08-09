# Contributing to Coder Kubernetes Template

Thank you for your interest in contributing! This guide will help you get started with development and testing.

## 🚀 Development Setup

### Prerequisites

1. **Tools Required:**
   - [Terraform](https://developer.hashicorp.com/terraform/downloads) (latest version)
   - [Git](https://git-scm.com/)
   - Access to a Kubernetes cluster
   - [kubectl](https://kubernetes.io/docs/tasks/tools/) configured for your cluster

2. **For Testing:**
   - [Coder CLI](https://coder.com/docs/v2/latest/install) 
   - Access to a Coder instance (for integration testing)

### Local Development

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Frantche/coder-template-kubernetes.git
   cd coder-template-kubernetes
   ```

2. **Validate the template locally:**
   ```bash
   ./validate.sh
   ```

3. **Make your changes:**
   - Template configuration: Edit `template-kubernetes/main.tf`
   - Documentation: Update relevant README files
   - CI/CD: Modify `.github/workflows/coder-template-update.yaml`

## 🧪 Testing

### Local Validation

The repository includes a validation script that checks:
- Terraform formatting (`terraform fmt -check`)
- Terraform configuration validity (`terraform validate`)

```bash
# Run all local tests
./validate.sh
```

### Manual Terraform Testing

```bash
cd template-kubernetes

# Initialize Terraform
terraform init

# Check formatting
terraform fmt -check

# Validate configuration
terraform validate

# Plan deployment (requires proper variables)
terraform plan
```

### Integration Testing

For full integration testing, you'll need access to a Coder instance:

1. **Set up Coder CLI:**
   ```bash
   coder login <your-coder-url>
   ```

2. **Push template for testing:**
   ```bash
   coder templates push test-kubernetes -d template-kubernetes
   ```

3. **Create a test workspace:**
   ```bash
   coder create test-workspace -t test-kubernetes
   ```

4. **Clean up test resources:**
   ```bash
   coder delete test-workspace
   coder templates delete test-kubernetes
   ```

## 🔄 GitHub Actions Testing

The repository includes automated testing via GitHub Actions:

### Pull Request Testing
- Automatically triggered on PRs to `main` branch
- Creates temporary template and workspace for validation
- Cleans up resources automatically

### Setting Up Testing Environment

If you want to test the GitHub Actions workflow:

1. **Fork the repository**
2. **Add required secrets** to your fork:
   - `CODER_SESSION_TOKEN`: Your Coder instance session token
3. **Update workflow configuration** (if needed):
   - Edit `access_url` in `.github/workflows/coder-template-update.yaml`
   - Modify `namespace` parameter if using different namespace

## 📝 Contribution Guidelines

### Code Style

- **Terraform**: Follow standard Terraform formatting (`terraform fmt`)
- **Documentation**: Use clear, concise language with proper markdown formatting
- **Commit Messages**: Use conventional commit format when possible

### Pull Request Process

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** with appropriate tests

3. **Run local validation:**
   ```bash
   ./validate.sh
   ```

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: description of your changes"
   ```

5. **Push and create PR:**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** with:
   - Clear description of changes
   - Any breaking changes noted
   - Testing steps performed

### What We Look For

- ✅ **Working Code**: Changes should not break existing functionality
- ✅ **Documentation**: Update relevant documentation for any changes
- ✅ **Testing**: Include appropriate tests or validation
- ✅ **Compatibility**: Ensure backward compatibility when possible

## 🐛 Reporting Issues

When reporting issues, please include:

1. **Template Version**: Commit SHA or version information
2. **Environment**: Kubernetes version, Coder version, etc.
3. **Steps to Reproduce**: Clear steps to reproduce the issue
4. **Expected vs Actual Behavior**: What you expected vs what happened
5. **Logs**: Relevant error messages or logs

## 💡 Feature Requests

Feature requests are welcome! Please:

1. **Check existing issues** to avoid duplicates
2. **Describe the use case** and why it would be valuable
3. **Provide implementation ideas** if you have them
4. **Consider backward compatibility** implications

## 🔧 Development Tips

### Common Development Tasks

1. **Adding new parameters:**
   - Add `coder_parameter` data source in `main.tf`
   - Update template README documentation
   - Test with different parameter values

2. **Modifying resource configuration:**
   - Update Kubernetes resources in `main.tf`
   - Ensure labels and annotations follow Coder conventions
   - Test resource creation and cleanup

3. **Updating dependencies:**
   - Renovate automatically manages Terraform provider versions
   - For Docker image updates, modify the `image` field and update renovate comment

### Debugging Tips

- **Template Issues**: Use `coder templates push --debug` for verbose output
- **Workspace Issues**: Check `coder show <workspace>` and Kubernetes pod logs
- **CI/CD Issues**: Review GitHub Actions logs and Coder template logs

## 📞 Getting Help

- **Issues**: Create a GitHub issue for bugs or questions
- **Discussions**: Use GitHub Discussions for general questions
- **Coder Community**: Join the [Coder Discord](https://discord.gg/coder) for real-time help

Thank you for contributing to make this template better for everyone! 🎉