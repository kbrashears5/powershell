<#
.DESCRIPTION
Clean up repos, check out main branch, and prune all origin

.PARAMETER path
Path to folder with repo folders in it

.PARAMETER branchToDelete
Branch name to delete

.PARAMETER mainBranchName
Branch name of the main branch
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $path,
    [Parameter(Mandatory = $true)]
    [string] $branchToDelete,
    [Parameter(Mandatory = $true)]
    [string] $mainBranchName
)

Clear-Host

$folders = Get-ChildItem -Path $path

foreach ($folder in $folders) {
    Write-Host $folder.FullName

    Set-Location $folder.FullName

    git checkout $mainBranchName

    git branch -D $branchToDelete

    git remote prune origin
}