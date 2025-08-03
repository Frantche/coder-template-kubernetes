# Coder Kubernetes Template

A Coder template for creating development workspaces on Kubernetes clusters.

## Structure

- `template-kubernetes/` - The main Coder template directory
  - `main.tf` - Terraform configuration for the Kubernetes workspace
  - `README.md` - Template-specific documentation
- `.github/workflows/` - CI/CD pipeline for testing and deployment
- `validate.sh` - Local validation script for testing

## Features

- Kubernetes-based workspaces with persistent storage
- Configurable CPU, memory, and disk resources
- Pre-installed code-server for web-based development
- Docker-in-Docker support for containerized development
- Comprehensive CI/CD testing pipeline

## Development

### Local Testing

Before submitting changes, run the local validation:

```bash
./validate.sh
```

### CI/CD Pipeline

The repository includes automated testing that:

1. **Validates** Terraform syntax and formatting
2. **Tests** template deployment on pull requests
3. **Updates** the production template on main branch merges
4. **Cleans up** test resources automatically

All tests must pass before changes can be merged.

## Usage

This template is automatically deployed to the Coder instance at `https://coder.frantchenco.page` when changes are merged to the main branch.

For more details on using this template, see the [template-specific documentation](template-kubernetes/README.md).