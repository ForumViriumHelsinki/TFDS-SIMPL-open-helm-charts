# Changelog

All notable changes to the TFDS-managed microservice Helm charts will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-28

### Added
- Initialized the `TFDS-SIMPL-open-helm-charts` monorepo to support the TFDS Flattened Architecture (Phase 1).
- Ingested raw Helm charts from the official SIMPL upstream v3.1.x release train:
  - `authentication-provider` (v2.12.4)
  - `users-roles` (v2.12.6)
  - `tier1-gateway` (v2.12.5)
  - `tier2-gateway` (v2.11.4)
  - `tier2-proxy` (v1.5.4)
  - `edc` (v1.0.21)
  - `fc-service` (v1.0.12)
  - `identity-provider` (v2.11.3)
  - `openbao-init` (v1.1.0)
  - `openbao-config` (v1.3.6)
  - `vault-webhook` (v1.3.0)
  - `kafka` (v1.2.2)
  - `postgres-cluster` (v1.2.0)
  - `catalogue-ui` (v2.2.0)
  - `contract-consumption-be` (v1.15.0)
  - `dagster` (v0.1.12)
  - `eck-monitoring` (v0.3.1)
  - `edc-connector-adapter` (v1.10.1)
  - `fe-authentication-provider` (v2.9.3)
  - `fe-identity-provider` (v2.10.6)
  - `fe-onboarding` (v2.12.3)
  - `fe-security-attribute-provider` (v2.9.3)
  - `fe-users-and-roles` (v2.12.5)
  - `frontend` (v1.2.2)
  - `infrastructure-be` (v1.3.4)
  - `infrastructure-consumption-monitoring-service` (v2.3.1)
  - `infrastructure-crossplane` (v2.1.2)
  - `onboarding` (v2.12.7)
  - `poc-charts` (v1.0.14)
  - `schema-manager-ui` (v1.1.1)
  - `sd-creation-wizard` (v1.19.0)
  - `sd-ui` (v1.5.0)
  - `security-attributes-provider` (v2.12.3)
  - `signer` (v0.0.7)
  - `simpl-contract` (v2.5.0)
  - `simpl-files` (v1.2.3)
  - `simpl-notification-service` (v2.1.1)
  - `simpl-schema-manager-charts` (v0.0.13)
  - `simpl-stubs` (v2.0.2)
  - `xfsc-advsearch` (v1.18.0)
- Inherited EUPL v1.2 licensing from the upstream SIMPL open-source project.

### Changed
- Unbundled all microservice charts from their original upstream "App-of-Apps" nested architectures so they can be consumed as independent Helm dependencies.
### Patched (TFDS Specific)
- `authentication-provider`: Modified `values.yaml` to natively include the `appConfig.openid-connect.certsEndpoint` property. This eliminates the need to inject this critical security requirement via ArgoCD `extraValues` blocks.
