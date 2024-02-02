# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- v0.0.10 Add GKE load balancer for ArgoCD
- v0.0.10 Add GKE load balancer for Argo Applications
- v0.0.11 Add cucumber tests on Java.
- v0.0.11 Add tfsec

## [0.0.9] - 2024-02-01

- v0.0.9 Added automated tests from Terraform.

## [0.0.8] - 2024-02-01

### Added

- v0.0.8 Update documentation.

## [0.0.7] - 2024-02-01

### Fixed

- v0.0.7 Removed unnecessary runs on bearer, build and terraform workflow.

### Changed

- v0.0.7 Adjustment on all pipeline triggers.

### Added

- v0.0.7 Add backend for terraform apply.
- v0.0.7 Add pipeline for terraform apply.

## [0.0.6] - 2024-02-01

### Fixed

- v0.0.6 App endpoint output was failing due to the helm chart not being completely deployed, added 'wait'.

### Removed

- v0.0.6 Removed kubernetes_manifest as it does not support creation of CRDs during new deployment of GKE cluster [see here](https://github.com/hashicorp/terraform-provider-kubernetes/issues/1775)

### Changed

- v0.0.6 Removed kubernetes_manifest in favor of [ArgoCD-Apps](https://artifacthub.io/packages/helm/argo/argocd-apps)

### Added

- v0.0.6 ArgoCD-Apps to deploy apps consistenly.
- v0.0.6 Output service endpoint for testing of app.

## [0.0.5] - 2024-02-01

### Added

- v0.0.5 Deploy Applications from Terraform.

## [0.0.4] - 2024-02-01

### Added

- v0.0.4 Add Image Updater for ArgoCD.
- V0.0.4 Configure ArgoCD Image Updater to read from pre configured Artifact Registry.

## [0.0.3] - 2024-01-31

### Changed

- Terraform "app" module renamed to "boostrap".

### Removed

- App deployment module removed in favor of using ArgoCD.
- Helm dependencies for ArgoCD deployment.

### Added

- GKE Bootstrap module that deploys GKE specific tools such as monitoring, CD tools, logging, service mesh.
- Added deployment charts to root folder as it will be managed by [ArgoC Application CRD](https://nandhabalanmarimuthu.medium.com/argo-cd-applications-b1e5bcb3c6af)

## [0.0.2] - 2024-01-29

### Added

- Added Automated workflow to build and publish docker images based on SemVer.

## [0.0.1] - 2024-01-26

### Added

- Deploy Infrastructure, microservice and test with a single comand.
- Manual steps to build and push a docker image to a registry.
