<#
.DESCRIPTION
Displays the SPNs and Delegations for Active Directory accounts

.PARAMETER domain
Domain to run query against

.PARAMETER userAccountNames
Array of SAMAccountNames
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $domain,
    [Parameter(Mandatory = $true)]
    [array]
    $userAccountNames
)

Clear-Host

function OutputList($listTitle, $listItems) {
    Write-Host "`t$listTitle"
 
    foreach ($listItem in $listItems  | Sort-Object) {
        Write-Host "`t`t$listItem"
    }
}
 
foreach ($userAccountName in $userAccountNames) {
    Write-Host "Account: $userAccountName"
 
    $userAccount = Get-ADUser $userAccountName -Properties servicePrincipalNames, msDS-AllowedToDelegateTo -Server $domain
 
    OutputList "Service Principal Names (SPNs)" $userAccount.servicePrincipalNames
 
    OutputList "Delegations" $userAccount.'msDS-AllowedToDelegateTo'
}