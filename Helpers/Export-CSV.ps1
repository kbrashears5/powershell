<#
.DESCRIPTION
Exports hash table to CSV

.PARAMETER csvPath
Path to export CSV to
#>
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $csvPath,
    [Parameter()]
    [hashtable]
    $hashTable
)

Clear-Host

# initialize empty array to write to csv
$csv = @()

# loop through hash table
ForEach ($hash in $hashTable.Keys) {
    # create item to push to csv array
    $item = [ordered] @{
        Column1 = $column1
    }

    # push to csv array
    $csv += New-Object PSObject -Property $item
}

# export to csv
$csv | Export-Csv -Path $csvPath -NoTypeInformation