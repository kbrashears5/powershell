<#
.DESCRIPTION
Gets an OAuth 2.0 access token

.PARAMETER url
URL of IDP provider

.PARAMETER clientId
Client id of application

.PARAMETER clientSecret
Client secret of application
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $url,
    [Parameter(Mandatory = $true)]
    [string]
    $clientId,
    [Parameter(Mandatory = $true)]
    [string]
    $clientSecret
)

$form = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
}

$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}

Write-Host "Getting OAuth 2.0 token"

$response = (Invoke-WebRequest -Method Post -Uri $url -Body $form -Headers $headers).Content | ConvertFrom-Json

Write-Host "OAuth 2.0 token received successfully"

$accessToken = $response.access_token
$accessToken