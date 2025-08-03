#!/bin/bash
set -e

# Simple validation script to test the Terraform template locally
echo "Running local validation tests..."

cd "$(dirname "$0")/template-kubernetes"

# Check if terraform is available
if ! command -v terraform &> /dev/null; then
    echo "Error: terraform is not installed"
    exit 1
fi

echo "✓ Terraform is installed"

# Check formatting
echo "Checking Terraform formatting..."
if terraform fmt -check; then
    echo "✓ Terraform formatting is correct"
else
    echo "✗ Terraform formatting issues found. Run 'terraform fmt' to fix."
    exit 1
fi

# Initialize and validate
echo "Initializing Terraform..."
terraform init

echo "Validating Terraform configuration..."
if terraform validate; then
    echo "✓ Terraform configuration is valid"
else
    echo "✗ Terraform validation failed"
    exit 1
fi

# Clean up
rm -rf .terraform .terraform.lock.hcl

echo "All local validation tests passed!"