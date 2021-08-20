<#
.DESCRIPTION
Clean up repos, check out main branch, and prune all origin

.PARAMETER path
Path to folder with repo folders in it

.PARAMETER mainBranchName
Branch name of the main branch

.PARAMETER branchToDelete
Branch name to delete
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $path,
    [Parameter(Mandatory = $true)]
    [string] $mainBranchName,
    [Parameter(Mandatory = $false)]
    [string] $branchToDelete
)

Clear-Host

$folders = Get-ChildItem -Path $path

foreach ($folder in $folders) {
    Write-Host $folder.FullName

    Set-Location $folder.FullName

    git checkout $mainBranchName

    if ($branchToDelete -ne $null) {
        git branch -D $branchToDelete
    }

    git remote prune origin
}