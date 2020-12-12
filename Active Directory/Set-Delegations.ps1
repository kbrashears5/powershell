<#
.DESCRIPTION
Sets delegations for given accounts

.PARAMETER domain
Domain to run against

.PARAMETER userAccountNames
Array of SAMAccountNames

.PARAMETER delegation
Delegation to set
Example: HTTP/servername

.PARAMETER fqdnDelegation
Fully qualified delegation to set
Example: HTTP/servername.domain.com
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $domain,
    [Parameter(Mandatory = $true)]
    [array]
    $userAccountNames,
    [Parameter(Mandatory = $true)]
    [string]
    $delegation,
    [Parameter(Mandatory = $true)]
    [string]
    $fqdnDelegation
)

Clear-Host
 
foreach ($userAccountName in $userAccountNames) {
    Write-Host "Account: $userAccountName"
 
    $userAccount = Get-ADUser $userAccountName -Properties servicePrincipalNames, msDS-AllowedToDelegateTo -Server $domain
 
    Set-ADObject $userAccount -Add @{'msDS-AllowedToDelegateTo' = $delegation }
    Set-ADObject $userAccount -Add @{'msDS-AllowedToDelegateTo' = $fqdnDelegation }
}