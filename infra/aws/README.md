# Terraform on AWS

This directory contains Terraform entry points for the school test and official AWS accounts. The current configuration is a **safe foundation only**: it declares provider/account context and outputs the selected identity, but creates no AWS resources.

## Safety model

- Use separate credentials, state, and variable files for each account.
- Run all application and integration testing in the designated test account. Keep exploratory cycles there to protect the official account's credit.
- Use the official account only to deploy the exact revision or image digest approved after test-account validation. Never reuse test credentials or test data in the official environment.
- Keep the official runtime stopped until the demonstration window, as already planned.
- `allowed_account_id` is required in each environment. The AWS provider rejects credentials for any other account.
- Do not place credentials, account IDs, or `*.tfvars` files in version control.
- Do not use the official environment for exploratory plans or tests.
- No Terraform apply should run until the demo service set, region, persistent data design, cost estimate, and state backend are approved.

## Layout

- `environments/test`: test account root module.
- `environments/official`: official account root module, for the approved artifact only.
- `modules`: reusable modules added after service requirements are confirmed.

## Initialize one environment

From the selected environment directory, provide the region and allowed account ID through an ignored local tfvars file, then run `terraform init` and `terraform plan`. The initial plan should contain no resource changes. Keep each environment's state in a separate backend key/bucket configured outside the committed files. Do not apply this foundation; it intentionally creates nothing.

Example local file (never commit):

```hcl
region            = "<approved-region>"
allowed_account_id = "<account-id-for-this-environment>"
```

Do not configure an S3 backend until the team has selected the account, region, encryption, access policy, and state ownership. The S3 bucket and its controls must be bootstrapped separately.
