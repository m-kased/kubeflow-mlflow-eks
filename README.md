# Kubeflow and MLflow on Amazon EKS Using Terraform

[![Terraform Version](https://img.shields.io/badge/Terraform-1.12%2B-blue)](https://www.terraform.io/downloads.html)
[![AWS EKS](https://img.shields.io/badge/Amazon-EKS-blue)](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

## Table of Contents
- [Purpose](#purpose)
- [Infrastructure Components](#infrastructure-components)
- [Architecture Overview](#architecture-overview)
- [ML Platform Features](#ml-platform-features)
  - [Kubeflow](#kubeflow)
  - [MLflow](#mlflow)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup Instructions](#setup-instructions)
- [Usage Examples](#usage-examples)
- [Troubleshooting & FAQ](#troubleshooting--faq)
- [Useful Resources](#useful-resources)
- [License](#license)

## Purpose

This project streamlines the setup of a production-ready machine learning platform on AWS. It leverages Terraform to automate EKS provisioning while integrating Kubeflow and MLflow—tools that empower you to build, track, and deploy ML models with ease.

## Infrastructure Components

- **Amazon EKS:** Managed Kubernetes for scalable, containerized ML workloads.
- **IAM Roles and Policies:** Ensure secure, fine-grained access control.
- **VPC & Networking:** Provide a robust network architecture for high availability.
- **Storage Solutions:** Enable persistent storage for ML artifacts and datasets.

## Architecture Overview

The architecture adopts a modular design:
- **EKS Cluster:** Central hub for running ML workloads.
- **Kubeflow:** Deployed within EKS for flexible, end-to-end ML workflows.
- **MLflow:** Integrated for experiment tracking and robust model management.
- **Terraform:** Automates the entire infrastructure lifecycle.

## ML Platform Features

### Kubeflow
- Modular ML workflows.
- Integrated Jupyter notebooks for experimentation.
- Distributed training capabilities.
- Scalable model serving.

### MLflow
- Intuitive experiment tracking.
- Comprehensive model registry and versioning.
- Seamless deployment pipelines.
- Collaborative logging and metrics.

## Getting Started

### Prerequisites
- AWS account with required permissions.
- [Terraform](https://www.terraform.io/downloads.html) (version 1.12 or later).
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
- [AWS CLI](https://aws.amazon.com/cli/) configured on your machine.

### Setup Instructions
1. Clone the repository.
2. Configure AWS credentials.
3. cd into the project folder and then into the `terraform` folder.
4. Update Terraform variables in `terraform.tfvars`.
5. Run `terraform init` and `terraform apply` to provision the infrastructure.
6. Access Kubeflow and MLflow dashboards through the provided endpoints.

## Usage Examples

Discover workflows for:
- **Model Training:** Seamlessly run distributed training jobs.
- **Experiment Tracking:** Log experiments and compare metrics.
- **Model Deployment:** Transition models from testing to production.
- **Monitoring:** Utilize built-in dashboards to troubleshoot and optimize performance.

## Troubleshooting & FAQ

- **Q:** What if `terraform apply` fails?  
  **A:** Verify AWS credentials and ensure all required variables in `terraform.tfvars` are configured.
  
- **Q:** How do I modify cluster settings?  
  **A:** Update the relevant Terraform scripts and re-run `terraform apply`.
  
- **Q:** Where can I view logs?  
  **A:** Check CloudWatch logs and the Kubernetes dashboard for detailed insights.

## Useful Resources

- [Kubeflow Documentation](https://www.kubeflow.org/docs/)
- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [Amazon EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS IAM Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.
Contributions are welcome! Please review the [CONTRIBUTING.md](CONTRIBUTING.md) guidelines before submitting a pull request.
