# Helm Chart for SIMPL FC Service

This directory contains the Helm chart for deploying the SIMPL FC Service application to Kubernetes.

## Quick Start

```bash
# Install the chart
helm install fc-service . --namespace your-namespace

# Upgrade the chart
helm upgrade fc-service . --namespace your-namespace
```

## Chart Structure

```
charts/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default configuration values
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    └── serviceaccount.yaml
```

## Configuration

The chart can be configured by modifying `values.yaml` or by providing custom values during installation.

Key configuration options:
- Application image and tag
- Resource limits and requests
- Service configuration
- Ingress settings
- Vault integration settings

## For Complete Deployment Instructions

**See [Deployment Guide](../documents/deployment-guide.md)** for:
- Prerequisites and dependencies
- Vault configuration steps
- Environment setup and secrets management
- Step-by-step deployment process
- Verification and troubleshooting guides

## Chart Development

```bash
# Validate chart syntax
helm lint .

# Render templates locally
helm template . --debug

# Test installation (dry-run)
helm install --dry-run --debug fc-service .
```  
