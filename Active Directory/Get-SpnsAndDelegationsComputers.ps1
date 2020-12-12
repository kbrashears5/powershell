<#
.DESCRIPTION
Displays the SPNs and Delegations for Active Directory computers

.PARAMETER domain
Domain to run query against

.PARAMETER computerNames
Array of Computer names
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $domain,
    [Parameter(Mandatory = $true)]
    [array]
    $computerNames
)

Clear-Host

function OutputList($listTitle, $listItems) {
    Write-Host "`t$listTitle"
 
    foreach ($listItem in $listItems  | Sort-Object) {
        Write-Host "`t`t$listItem"
    }
}
 
foreach ($userAccountName in $computerNames) {
    Write-Host "Account: $userAccountName"
 
    $userAccount = Get-ADComputer $userAccountName -Properties servicePrincipalNames, msDS-AllowedToDelegateTo -Server $domain
 
    OutputList "Service Principal Names (SPNs)" $userAccount.servicePrincipalNames
 
    OutputList "Delegations" $userAccount.'msDS-AllowedToDelegateTo'
}