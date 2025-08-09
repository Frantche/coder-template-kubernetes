---
name: Develop in Kubernetes
description: Get started with Kubernetes development.
tags: [cloud, kubernetes]
icon: /icon/k8s.png
---

# Kubernetes Development Template

This template creates a pod running a custom development image (`ghcr.io/frantche/coder-full`) with Docker support, code-server, and persistent storage for cloud-native development.

## ✨ Features

- **Full Development Environment**: Pre-configured with development tools
- **Docker-in-Docker**: Build and run containers within your workspace
- **Code-Server**: Web-based VS Code editor
- **Persistent Storage**: Home directory persisted across workspace sessions
- **Resource Configuration**: Configurable CPU, memory, and disk resources
- **Anti-Affinity**: Workspaces distributed across nodes for better performance

## 🚀 Quick Start

1. Set the required variables when pushing the template
2. Create a workspace with your preferred resource configuration
3. Access your development environment through code-server or SSH

## 🔧 Configuration Parameters

This template supports the following configurable parameters:

### CPU Allocation
- **Options**: 2, 4, 6, or 8 cores
- **Default**: 2 cores
- **Mutable**: Yes (can be changed after workspace creation)

### Memory Allocation  
- **Options**: 2, 4, 6, or 8 GB
- **Default**: 2 GB
- **Mutable**: Yes (can be changed after workspace creation)

### Home Disk Size
- **Range**: 1-99999 GB
- **Default**: 10 GB
- **Mutable**: No (set at workspace creation time)

## 🔐 Authentication

This template can authenticate using in-cluster authentication, or using a kubeconfig local to the
Coder host. For additional authentication options, consult the [Kubernetes provider
documentation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs).

### kubeconfig on Coder host

If the Coder host has a local `~/.kube/config`, you can use this to authenticate
with Coder. Make sure this is done with same user that's running the `coder` service.

To use this authentication, set the parameter `use_kubeconfig` to true.

### In-cluster authentication

If the Coder host runs in a Pod on the same Kubernetes cluster as you are creating workspaces in,
you can use in-cluster authentication.

To use this authentication, set the parameter `use_kubeconfig` to false.

The Terraform provisioner will automatically use the service account associated with the pod to
authenticate to Kubernetes. Be sure to bind a [role with appropriate permission](#rbac) to the
service account. For example, assuming the Coder host runs in the same namespace as you intend
to create workspaces:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: coder

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: coder
subjects:
  - kind: ServiceAccount
    name: coder
roleRef:
  kind: Role
  name: coder
  apiGroup: rbac.authorization.k8s.io
```

Then start the Coder host with `serviceAccountName: coder` in the pod spec.

### Authenticate against external clusters

You may want to deploy workspaces on a cluster outside of the Coder control plane. Refer to the [Coder docs](https://coder.com/docs/v2/latest/platforms/kubernetes/additional-clusters) to learn how to modify your template to authenticate against external clusters.

## 📦 Namespace

The target namespace in which the pod will be deployed is defined via the `namespace`
variable. The namespace must exist prior to creating workspaces.

**Important**: Ensure the namespace exists and has appropriate RBAC permissions before deploying workspaces.

## 💾 Persistence

The `/home/coder` directory in this example is persisted via the attached PersistentVolumeClaim.
Any data saved outside of this directory will be wiped when the workspace stops.

Since most binary installations and environment configurations live outside of
the `/home` directory, we suggest including these in the `startup_script` argument
of the `coder_agent` resource block, which will run each time the workspace starts up.

For example, when installing the `aws` CLI, the install script will place the
`aws` binary in `/usr/local/bin/aws`. To ensure the `aws` CLI is persisted across
workspace starts/stops, include the following code in the `coder_agent` resource
block of your workspace template:

```terraform
resource "coder_agent" "main" {
  startup_script = <<-EOT
    set -e
    # install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
  EOT
}
```

## 💻 code-server

`code-server` is installed via the `startup_script` argument in the `coder_agent`
resource block. The `coder_app` resource is defined to access `code-server` through
the dashboard UI over `localhost:13337`.

### Features
- **Web-based VS Code**: Full VS Code experience in your browser
- **Extensions Support**: Install VS Code extensions as needed
- **File Explorer**: Access to your entire workspace filesystem
- **Integrated Terminal**: Built-in terminal access

## 🐳 Docker Support

This template includes Docker-in-Docker support, allowing you to:
- Build and run containers within your workspace
- Use Docker Compose for multi-container applications
- Access the Docker daemon directly

## 📊 Monitoring

The workspace includes several built-in monitoring metrics:
- CPU usage (workspace and host)
- Memory usage (workspace and host)  
- Disk usage for home directory
- Load average on the host

## 🔍 Troubleshooting

### Common Issues

**Workspace won't start:**
- Check namespace exists and has proper permissions
- Verify PersistentVolume storage class is available
- Review Kubernetes pod logs for startup errors

**Code-server not accessible:**
- Wait for the startup script to complete (check agent logs)
- Verify port 13337 is not blocked
- Check the healthcheck status in Coder dashboard

**Docker not working:**
- Ensure the container runs with privileged mode
- Check if Docker daemon started successfully in workspace logs

### Getting Help

- Check workspace logs in Coder dashboard
- Review Kubernetes pod logs: `kubectl logs <pod-name> -n <namespace>`
- Verify agent connectivity in Coder dashboard