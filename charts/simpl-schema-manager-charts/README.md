# Helm Chart for POC GAIA EDC

This directory contains the Helm chart for deploying the SIMPL Schema Manager application to Kubernetes.

## Quick Start

```bash
# Install the chart
helm install simpl-schema-manager . --namespace your-namespace

# Upgrade the chart
helm upgrade simpl-schema-manager . --namespace your-namespace
```

## Chart Structure

```
charts/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default configuration values
└── templates/
    ├── deployment.yaml
    ├── fusekiService.yaml
    ├── ingress.yaml
    ├── schemaManagerService.yaml
    ├── serviceAccount.yaml
    └── statefulset.yaml
```

## Configuration

The chart can be configured by modifying `values.yaml` or by providing custom values during installation.

Key configuration options:
- Application image and tag
- Service configuration
- Resource limits and requests
- Vault integration settings
- Ingress settings


## For Complete Deployment Instructions

**See [Deployment Guide](../documents/deployment-guide.md)** for:
- Prerequisites and dependencies
- Vault configuration
- Environment setup
- Step-by-step deployment process
- Verification and troubleshooting

## Chart Development

```bash
# Validate chart syntax
helm lint .

# Render templates locally
helm template . --debug

# Test installation (dry-run)
helm install --dry-run --debug simpl-schema-manager .
```
