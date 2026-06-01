# Included Microservices (TFDS-SIMPL-open-helm-charts)

This document provides a quick-reference index of all the SIMPL upstream microservices currently ingested, patched, and managed within this repository. 

It details the chart name, the pinned upstream version (from SIMPL 3.1.x), the original source URL, and the TFDS agents that rely on the service.

*Note: Third-party dependencies (like Bitnami Keycloak or Redis) are strictly managed via Chart.yaml references and are NOT hosted in this directory.*

## Microservice Index

| Component Name | Pinned Version | Consuming Agent(s) | Source Repository URL |
|---|---|---|---|
| `authentication-provider` | `2.12.4` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/authentication_provider.git |
| `catalogue-ui` | `2.2.0` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-catalogue-client.git |
| `contract-consumption-be` | `1.15.0` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/data1/contract-consumption-be.git |
| `dagster` | `0.1.12` | Provider | https://code.europa.eu/simpl/simpl-open/development/orchestration-platform/dagster.git |
| `eck-monitoring` | `0.5.6` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/monitoring/eck-monitoring.git |
| `edc` | `1.0.21` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-edc.git |
| `edc-connector-adapter` | `1.10.1` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/data1/edcconnectoradapter.git |
| `fc-service` | `1.0.12` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-fc-service.git |
| `fe-authentication-provider` | `2.9.3` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/fe-authentication-provider.git |
| `fe-identity-provider` | `2.10.6` | GA | https://code.europa.eu/simpl/simpl-open/development/iaa/fe-identity-provider.git |
| `fe-onboarding` | `2.12.3` | GA | https://code.europa.eu/simpl/simpl-open/development/iaa/fe-onboarding.git |
| `fe-security-attribute-provider` | `2.9.3` | GA | https://code.europa.eu/simpl/simpl-open/development/iaa/fe-security-attribute-provider.git |
| `fe-users-and-roles` | `2.12.5` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/fe-users-and-roles.git |
| `frontend` | `1.2.2` | Provider | https://code.europa.eu/simpl/simpl-open/development/infrastructure/infrastructure-fe.git |
| `identity-provider` | `2.11.4` | GA | https://code.europa.eu/simpl/simpl-open/development/iaa/identity-provider.git |
| `infrastructure-be` | `1.3.4` | Provider | https://code.europa.eu/simpl/simpl-open/development/infrastructure/infrastructure-be.git |
| `infrastructure-consumption-monitoring-service` | `2.3.1` | Common Components | https://code.europa.eu/simpl/simpl-open/development/monitoring/infrastructure-consumption-monitoring-service.git |
| `infrastructure-crossplane` | `2.1.2` | Provider | https://code.europa.eu/simpl/simpl-open/development/infrastructure/infrastructure-crossplane.git |
| `kafka` | `1.2.2` | Common Components | https://code.europa.eu/simpl/simpl-open/development/common-components/kafka.git |
| `onboarding` | `2.12.8` | GA | https://code.europa.eu/simpl/simpl-open/development/iaa/onboarding.git |
| `openbao-config` | `1.3.6` | Common Components | https://code.europa.eu/simpl/simpl-open/development/common-components/openbao.git |
| `openbao-init` | `1.1.0` | Common Components | https://code.europa.eu/simpl/simpl-open/development/common-components/openbao-init.git |
| `poc-charts` | `1.0.14` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/poc-gaia-edc.git |
| `postgres-cluster` | `1.2.0` | Common Components | https://code.europa.eu/simpl/simpl-open/development/common-components/postgres-cluster.git |
| `schema-manager-ui` | `1.1.1` | GA | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-schema-manager-ui.git |
| `sd-creation-wizard` | `1.19.0` | Provider | https://code.europa.eu/simpl/simpl-open/development/data1/sdtooling-api-be.git |
| `sd-ui` | `1.5.0` | Provider | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-sd-ui.git |
| `security-attributes-provider` | `2.12.4` | GA | https://code.europa.eu/simpl/simpl-open/development/iaa/security-attributes-provider.git |
| `signer` | `0.0.7` | Provider | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-signer.git |
| `simpl-contract` | `2.5.0` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/contract-billing/contract.git |
| `simpl-files` | `1.2.3` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/data1/simpl-files.git |
| `simpl-notification-service` | `2.1.1` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/contract-billing/notification-service.git |
| `simpl-schema-manager-charts` | `0.0.13` | GA | https://code.europa.eu/simpl/simpl-open/development/gaia-x-edc/simpl-schema-manager.git |
| `simpl-stubs` | `2.0.2` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/contract-billing/stubs.git |
| `tier1-gateway` | `2.12.5` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/tier1-gateway.git |
| `tier2-gateway` | `2.11.4` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/tier2-gateway.git |
| `tier2-proxy` | `1.5.5` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/tier2-proxy.git |
| `users-roles` | `2.12.8` | Consumer, Provider, GA | https://code.europa.eu/simpl/simpl-open/development/iaa/users-roles.git |
| `vault-webhook` | `1.3.0` | Common Components | https://code.europa.eu/simpl/simpl-open/development/common-components/vault.git |
| `xfsc-advsearch` | `1.18.0` | Consumer, Provider | https://code.europa.eu/simpl/simpl-open/development/data1/xfsc-advsearch-be.git |
