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
Each directory in this repository represents an independent Helm chart.
