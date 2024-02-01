# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- v0.0.4 Add Image Updater for ArgoCD.
- V0.0.4 

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
