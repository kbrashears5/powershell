<#
.DESCRIPTION
Run a SQL server query

.PARAMETER query
Query to run
Example: "select top 10 * from table where cre_ts > SYSDATE"

.PARAMETER connectionString
Connection string to database
Example: "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(Host=SERVERNAME)(Port=PORT)))(CONNECT_DATA=(SID = SID)));User ID=readonly;Password=readonly"
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $query,
    [Parameter(Mandatory = $true)]
    [string]
    $connectionString
)

Clear-Host

Try {
    # load oracle driver
    [System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient")

    # create new connection to database
    Write-Host "Creating database connection"
    $connection = New-Object System.Data.OracleClient.OracleConnection($connectionString)

    # create sql command
    Write-Host "Executing SQL command"
    $command = New-Object System.Data.OracleClient.OracleCommand($query, $connection)

    # create oracle adapter to fill results
    $adapter = New-Object System.Data.OracleClient.OracleDataAdapter($command)

    # create empty data set for results
    $dataSet = New-Object System.Data.DataSet

    # fill the dataset
    Write-Host "Filling dataset"
    $adapter.Fill($dataSet) | Out-Null

    # close the connection
    Write-Host "Closing connection"
    $connection.Close()

    # create variable for temp path to export CSV
    $guid = New-Guid
    $tempPath = "C:\temp\$guid.csv"

    # if no data was returned from query, exit script
    If ($dataset.Tables[0].Rows.Count -eq 0) { 
        Write-Host "No data returned"
        Exit 0
    }

    # export to csv
    Write-Host "Exportint to $tempPath"
    $dataset.Tables[0] | Export-Csv -Path $tempPath -NoTypeInformation
}
Catch {
    $_
    Exit 1
}