<#
.DESCRIPTION
Adds the accounts to the servers Administrators group

.PARAMETER accounts
Accounts to give Administrator access to

.PARAMETER servers
Server names to give the Administrator access on
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [array]
    $accounts,
    [Parameter(Mandatory = $true)]
    [array]
    $servers
)

Clear-Host

$group = "Administrators"

$scriptBlock = {
    $accounts = $args[0]

    $group = $args[1]
    
    Add-LocalGroupMember -Group $group -Member $accounts
}

foreach ($server in $servers) {
    Invoke-Command -ComputerName $server -ScriptBlock $scriptBlock -ArgumentList @($accounts, $group)
}