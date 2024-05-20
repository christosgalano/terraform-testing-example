# terraform-testing-example

An opinionated example of how to test Terraform configurations. It includes:

- **Terraform Configurations:** A simple architecture that creates an Azure Web App, Key Vault, and associated resources. This demonstrates how to structure and organize Terraform code.
- **Tests:** Contract and integration tests that ensure the Terraform code behaves as expected. These tests are located in the tests directory and provide examples of how to write and structure tests for Terraform code.
- **GitHub Workflows:** Automated workflows for continuous integration and deployment. These workflows, located in the .github/workflows directory, automate the process of scanning the code for issues, running the tests, and deploying the infrastructure.
- **Configuration Files:** These files configure various tools used in the repository, such as tflint, trivy, checkov, and terraform-docs. They demonstrate how to set up and configure these tools for use with Terraform.

This repository follows best practices for Terraform development and uses GitHub workflows for automation. It serves as a practical example of how to test and deploy Terraform code.
