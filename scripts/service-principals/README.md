# Service principals

## Overview

- Service principals are required for both staging and production subscriptions to carry out deploys.
- They expire every 12 months and you will get a 401 if you try to use an expired token. e.g. `Error: Error building account: Error getting authenticated object ID: Error listing Service Principals`
- Tokens were last generated 17th July 2020, so expect to require a new token July 2021.
- Please check Confluence for more information on how the Service principals are used.

## Generating a new service principal

- Both staging (non-prod) and production subscriptions operate using their own individual service principals.
- To create new service principles the user must either have the  *Owner* role or have the *User Access Administrator* role
- Ensure you are logged in to `az` and the appropriate subscription has been set.
- Generate a new token for a subscription using the following command:
`az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRPTION_ID"`
- The raw output from the command should be stored in the service principals directory of Keybase under a new filename e.g. `StagingSPYYYY.txt`.
- For staging, update the respective client id and secret in the symlinked state.tf file.

## Additional information

- For additional information please see https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html
