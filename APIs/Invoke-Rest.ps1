<#
.DESCRIPTION
Example of how to invoke a REST API Call
#>

Clear-Host

$headers = @{
    "Authorization" = "Basic abc123"
    "Content-Type"  = "application/json"
}

$body = @{
    
} | ConvertTo-Json -Depth 5

$response = Invoke-RestMethod -Method Post -Uri $url -Headers $headers -Body $body
Write-Host $response