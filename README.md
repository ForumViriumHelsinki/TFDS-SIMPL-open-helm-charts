# TFDS-SIMPL-open-helm-charts

Centralized monorepo hosting the flattened, TFDS-managed Helm charts. 

## Overview
This repository acts as the single source of truth for the Level 3 microservices utilized by the TFDS agents (Governance Authority, Data Provider, Data Consumer) as well as the shared infrastructure managed by the TFDS Common Components agent.

These charts are originally forked from the upstream SIMPL Open project (v3.1.x release train) and have been extracted from their nested App-of-Apps bundles to support a flattened, highly-visible GitOps deployment model.

## Licensing & Compliance
This project is licensed under the **European Union Public Licence (EUPL) v1.2**, inheriting the license of the upstream SIMPL repositories.

### Upstream Modifications
In accordance with EUPL v1.2, the following modifications have been made to the original upstream SIMPL charts:
* **Architecture:** Charts have been unbundled from their upstream umbrella structures to function as independent, natively resolvable Helm dependencies.
* **Routing & Identity:** Specific charts (e.g., `authentication-provider`) have been patched to natively expect and process TFDS multi-domain routing variables, such as dynamically assigning the `certsEndpoint` to the correct Tier 2 Governance Authority endpoints.

*Please refer to the `CHANGELOG.md` inside each chart directory for detailed, chart-specific modifications.*

## Structure
The repository utilizes a standard Helm monorepo pattern. All microservice charts are located in the unified `/charts` directory.

```
.
├── CHANGELOG.md
├── INCLUDED_MICROSERVICES.md
├── LICENSE
├── README.md
├── scripts/
│   └── update_microservices.sh
└── charts/
    ├── authentication-provider/
    ├── catalogue-ui/
    ├── contract-consumption-be/
    ├── dagster/
    ├── eck-monitoring/
    ├── edc/
    ├── edc-connector-adapter/
    ├── fc-service/
    ├── fe-authentication-provider/
    ├── fe-identity-provider/
    ├── fe-onboarding/
    ├── fe-security-attribute-provider/
    ├── fe-users-and-roles/
    ├── frontend/
    ├── identity-provider/
    ├── infrastructure-be/
    ├── infrastructure-consumption-monitoring-service/
    ├── infrastructure-crossplane/
    ├── kafka/
    ├── onboarding/
    ├── openbao-config/
    ├── openbao-init/
    ├── poc-charts/
    ├── postgres-cluster/
    ├── schema-manager-ui/
    ├── sd-creation-wizard/
    ├── sd-ui/
    ├── security-attributes-provider/
    ├── signer/
    ├── simpl-contract/
    ├── simpl-files/
    ├── simpl-notification-service/
    ├── simpl-schema-manager-charts/
    ├── simpl-stubs/
    ├── tier1-gateway/
    ├── tier2-gateway/
    ├── tier2-proxy/
    ├── users-roles/
    ├── vault-webhook/
    └── xfsc-advsearch/
```