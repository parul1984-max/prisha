name: 'Terraform'

on:
  push:
    branches: [ "main" ]
  pull_request:
  workflow_dispatch:    

permissions:
  contents: read

env:
  ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
  ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
  ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
  ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest
    environment: production

    defaults:
      run:
        shell: bash

    steps:
    - name: Checkout
      uses: actions/checkout@v4

    # Use v2 to avoid deprecated set-output usage
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}
        terraform_version: latest

    - name: Terraform Init
      run: terraform init -input=false -no-color

    - name: Terraform Format (check)
      run: |
        echo "Running terraform fmt -check..."
        if ! terraform fmt -check -recursive -diff; then
          echo "::error::Terraform files are not formatted. Run 'terraform fmt -recursive' locally to fix formatting."
          # Exit with non-zero so CI fails and caller can fix formatting before merge
          exit 1
        fi

    - name: Terraform Plan
      run: |
        echo "Running terraform plan..."
        if ! terraform plan -input=false -no-color; then
          echo "::error::terraform plan failed. Inspect the plan output above for details."
          exit 1
        fi

    - name: Terraform Apply
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      run: |
        echo "Running terraform apply..."
        if ! terraform apply -auto-approve -input=false -no-color; then
          echo "::error::terraform apply failed. Inspect the apply output above for details."
          exit 1
        fi
